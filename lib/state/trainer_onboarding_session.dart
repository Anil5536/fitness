import '../data/mock_data.dart';
import '../data/models.dart';

/// Plain mutable state for one trainer onboarding run. See
/// [ClientOnboardingSession] for why this isn't a ChangeNotifier.
class TrainerOnboardingSession {
  String phone = kDemoPhoneSingle;
  bool otpVerified = false;

  String firstName = TrainerProfileDefaults.firstName;
  String lastName = TrainerProfileDefaults.lastName;
  String city = TrainerProfileDefaults.city;
  Gender? gender = TrainerProfileDefaults.gender;

  String yearsExperience = TrainerProfileDefaults.yearsExperience;
  List<String> certifications = List.of(TrainerProfileDefaults.certifications);
  Set<String> specialities = Set.of(TrainerProfileDefaults.specialities);
  CoachingMode? mode = TrainerProfileDefaults.mode;

  String handle = TrainerProfileDefaults.handle;
  String trainerCode = kMockCode;
}
