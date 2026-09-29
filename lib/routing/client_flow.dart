import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../data/models.dart';
import '../screens/client/c4_trainer_code_screen.dart';
import '../screens/client/c5_connected_screen.dart';
import '../screens/client/c5b_connected_multiple_screen.dart';
import '../screens/client/c6_profile_screen.dart';
import '../screens/client/c7_body_basics_screen.dart';
import '../screens/client/c8_done_screen.dart';
import '../screens/client/client_home_stub_screen.dart';
import '../screens/shared/otp_verify_screen.dart';
import '../screens/shared/phone_entry_screen.dart';
import '../state/client_onboarding_session.dart';
import '../widgets/role_chip.dart';

/// All branching decisions for the client flow live here — screens stay
/// "dumb" and just call back into whichever coordinator method fired.
abstract final class ClientFlow {
  static void start(BuildContext context) {
    final session = ClientOnboardingSession();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PhoneEntryScreen(
          role: AppRole.client,
          headerVariant: PhoneHeaderVariant.wordmark,
          headline: 'Welcome',
          subhead: 'Sign in with the number your trainer has for you.',
          initialPhone: '',
          onSendOtp: (phone) => _onSendOtp(context, session, phone),
          onTrainerCodeTap: () => _onTrainerCodeTap(context, session),
        ),
      ),
    );
  }

  static void _onSendOtp(BuildContext context, ClientOnboardingSession session, String phone) {
    session.phone = phone;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerifyScreen(
          role: AppRole.client,
          phoneDisplay: phone,
          expectedCode: kMockCode,
          onSuccess: () => onOtpVerified(context, session, phone),
        ),
      ),
    );
  }

  static void onOtpVerified(BuildContext context, ClientOnboardingSession session, String phone) {
    session.otpVerified = true;
    session.entryPath = entryPathForPhone(phone);

    if (session.entryPath == ClientEntryPath.demoPhoneMultiple) {
      session.matchedTrainers = kAllTrainers;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => C5bConnectedMultipleScreen(
            trainers: session.matchedTrainers,
            onContinue: (t) => onMultiTrainerPicked(context, session, t),
          ),
        ),
      );
      return;
    }

    session.matchedTrainers = const [kAarav];
    session.selectedTrainer = kAarav;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => C5ConnectedScreen(
          trainer: kAarav,
          // Aarav's invite already has Sneha's name on file.
          clientInitials: 'SN',
          onContinue: () => onConnectedContinue(context, session),
        ),
      ),
    );
  }

  static void _onTrainerCodeTap(BuildContext context, ClientOnboardingSession session) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => C4TrainerCodeScreen(
          expectedCode: kMockCode,
          trainer: kAarav,
          onContinue: () => onCodeEntryVerified(context, session),
        ),
      ),
    );
  }

  static void onCodeEntryVerified(BuildContext context, ClientOnboardingSession session) {
    session.entryPath = ClientEntryPath.trainerCode;
    session.otpVerified = true;
    session.matchedTrainers = const [kAarav];
    session.selectedTrainer = kAarav;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => C5ConnectedScreen(
          trainer: kAarav,
          // Code-entry means no pre-existing client record to name yet.
          clientInitials: null,
          onContinue: () => onConnectedContinue(context, session),
        ),
      ),
    );
  }

  static void onMultiTrainerPicked(
    BuildContext context,
    ClientOnboardingSession session,
    TrainerMock trainer,
  ) {
    session.selectedTrainer = trainer;
    _pushProfile(context, session, prefill: null);
  }

  static void onConnectedContinue(BuildContext context, ClientOnboardingSession session) {
    final prefill = session.entryPath == ClientEntryPath.defaultPhoneSingle ? kSnehaPrefill : null;
    _pushProfile(context, session, prefill: prefill);
  }

  static void _pushProfile(
    BuildContext context,
    ClientOnboardingSession session, {
    required ClientPrefillData? prefill,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => C6ProfileScreen(
          session: session,
          prefill: prefill,
          onNext: () => onProfileNext(context, session),
        ),
      ),
    );
  }

  static void onProfileNext(BuildContext context, ClientOnboardingSession session) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => C7BodyBasicsScreen(
          session: session,
          onFinish: () => onBodyBasicsFinish(context, session),
        ),
      ),
    );
  }

  static void onBodyBasicsFinish(BuildContext context, ClientOnboardingSession session) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => C8DoneScreen(
          firstName: session.firstName,
          onGoHome: () => onDone(context),
        ),
      ),
    );
  }

  static void onDone(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const ClientHomeStubScreen()),
      (route) => false,
    );
  }
}
