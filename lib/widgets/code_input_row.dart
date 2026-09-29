import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/colors.dart';
import '../core/radii.dart';
import '../core/typography.dart';

/// Shared 6-digit code entry used by both OTP screens (C3/T2) and the
/// trainer-code fallback (C4) — all three just check the entered digits
/// against [expectedCode] and call [onSuccess]; a mismatch shows the
/// same red-outline error treatment (the design only draws this state
/// for OTP, but C4 has no designed error state of its own, so it's
/// reused here for consistency — see plan).
///
/// The static mockup shows pre-filled example digits for its "good" and
/// "bad" states; this widget always starts empty and evaluates once all
/// digits are entered.
class CodeInputRow extends StatefulWidget {
  const CodeInputRow({
    super.key,
    this.length = 6,
    required this.expectedCode,
    required this.onSuccess,
    this.onError,
  });

  final int length;
  final String expectedCode;
  final VoidCallback onSuccess;
  final VoidCallback? onError;

  @override
  State<CodeInputRow> createState() => _CodeInputRowState();
}

class _CodeInputRowState extends State<CodeInputRow> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _error = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_error) setState(() => _error = false);
    if (value.length == widget.length) {
      if (value == widget.expectedCode) {
        widget.onSuccess();
      } else {
        setState(() => _error = true);
        widget.onError?.call();
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Stack(
        children: [
          Row(
            children: List.generate(widget.length, (i) {
              final has = i < _controller.text.length;
              final char = has ? _controller.text[i] : '';
              final borderColor = _error && has
                  ? AppColors.coral
                  : has
                  ? AppColors.ink
                  : AppColors.ink.withValues(alpha: 0.12);
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i == widget.length - 1 ? 0 : 8),
                  child: AspectRatio(
                    aspectRatio: 1 / 1.15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadii.box),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        char,
                        style: AppText.mono(24, weight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(widget.length),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                onChanged: _onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
