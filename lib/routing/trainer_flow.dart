import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../screens/shared/otp_verify_screen.dart';
import '../screens/shared/phone_entry_screen.dart';
import '../screens/trainer/t3_profile_screen.dart';
import '../screens/trainer/t4_coaching_screen.dart';
import '../screens/trainer/t5_handle_screen.dart';
import '../screens/trainer/t6_done_screen.dart';
import '../screens/trainer/trainer_home_stub_screen.dart';
import '../state/trainer_onboarding_session.dart';
import '../widgets/role_chip.dart';

abstract final class TrainerFlow {
  static void start(BuildContext context) {
    final session = TrainerOnboardingSession();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PhoneEntryScreen(
          role: AppRole.trainer,
          headerVariant: PhoneHeaderVariant.roleChip,
          headline: "Let's get your clients in one place.",
          subhead: "We'll text you a code. No password to remember.",
          initialPhone: session.phone,
          showFreeCaption: true,
          onSendOtp: (phone) => _onSendOtp(context, session, phone),
        ),
      ),
    );
  }

  static void _onSendOtp(BuildContext context, TrainerOnboardingSession session, String phone) {
    session.phone = phone;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerifyScreen(
          role: AppRole.trainer,
          phoneDisplay: phone,
          expectedCode: kMockCode,
          showResendButton: true,
          onSuccess: () => onOtpVerified(context, session),
        ),
      ),
    );
  }

  static void onOtpVerified(BuildContext context, TrainerOnboardingSession session) {
    session.otpVerified = true;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => T3ProfileScreen(
          session: session,
          onNext: () => onProfileNext(context, session),
        ),
      ),
    );
  }

  static void onProfileNext(BuildContext context, TrainerOnboardingSession session) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => T4CoachingScreen(
          session: session,
          onNext: () => onCoachingNext(context, session),
        ),
      ),
    );
  }

  /// Both "Next" and "Skip for now" on T4 land here — see [T4CoachingScreen].
  static void onCoachingNext(BuildContext context, TrainerOnboardingSession session) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => T5HandleScreen(
          session: session,
          onFinish: () => onHandleFinish(context, session),
        ),
      ),
    );
  }

  static void onHandleFinish(BuildContext context, TrainerOnboardingSession session) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => T6DoneScreen(
          handle: session.handle,
          onGoHome: () => onDone(context),
        ),
      ),
    );
  }

  static void onDone(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const TrainerHomeStubScreen()),
      (route) => false,
    );
  }
}
