import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/typography.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/role_chip.dart';
import '../../widgets/tab_bar.dart';

/// The design board doesn't include the main trainer dashboard — see
/// [ClientHomeStubScreen] for why this stub exists.
class TrainerHomeStubScreen extends StatefulWidget {
  const TrainerHomeStubScreen({super.key});

  @override
  State<TrainerHomeStubScreen> createState() => _TrainerHomeStubScreenState();
}

class _TrainerHomeStubScreenState extends State<TrainerHomeStubScreen> {
  int _activeIndex = 0;
  final _tabs = const ['Home', 'Leads', 'Clients', 'Plans', 'More'];

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
            role: AppRole.trainer,
            activeIndex: _activeIndex,
            overdueCount: 0,
            onTap: (i) => setState(() => _activeIndex = i),
          ),
        ],
      ),
    );
  }
}
