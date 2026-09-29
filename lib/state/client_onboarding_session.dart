import '../data/models.dart';

/// Plain mutable state for one client onboarding run — constructed fresh
/// each time a user picks "I'm a client", threaded forward by reference
/// through Navigator pushes. No ChangeNotifier/Provider: every mutation
/// happens right before the next screen is pushed, so the next screen
/// simply reads current values in its own build() — nothing needs a
/// reactive rebuild of an already-mounted screen.
class ClientOnboardingSession {
  String phone = '';
  bool otpVerified = false;
  ClientEntryPath entryPath = ClientEntryPath.defaultPhoneSingle;
  List<TrainerMock> matchedTrainers = [];
  TrainerMock? selectedTrainer;

  String firstName = '';
  String lastName = '';
  String city = '';
  Gender? gender;
  DateTime? dob;

  double? heightCm;
  double? weightKg;
  double? targetWeightKg;
  Diet? diet;
  String injuries = '';
}
