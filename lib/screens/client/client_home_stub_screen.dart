import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/typography.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/role_chip.dart';
import '../../widgets/tab_bar.dart';

/// The design board doesn't include the main client dashboard — this is
/// a minimal, deliberately unstyled stub so the onboarding flow has
/// somewhere real to land, and so [RoutinelyTabBar] is exercised end to
/// end. Not part of the original design.
class ClientHomeStubScreen extends StatefulWidget {
  const ClientHomeStubScreen({super.key});

  @override
  State<ClientHomeStubScreen> createState() => _ClientHomeStubScreenState();
}

class _ClientHomeStubScreenState extends State<ClientHomeStubScreen> {
  int _activeIndex = 0;
  final _tabs = const ['Today', 'Plan', 'Progress', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(_tabs[_activeIndex], style: AppText.headline(28)),
            ),
          ),
          RoutinelyTabBar(
            role: AppRole.client,
            activeIndex: _activeIndex,
            onTap: (i) => setState(() => _activeIndex = i),
          ),
        ],
      ),
    );
  }
}
