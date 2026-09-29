import 'models.dart';

/// This one 6-digit string plays three roles in the design's mock data:
/// the "correct" OTP for both flows, the trainer code accepted by C4,
/// and the trainer code shown/copyable on T5. The design collapses these
/// to one memorable value for the mockup — kept as a single shared
/// constant (rather than three coincidentally-equal ones) so a future
/// change to one doesn't silently desync the others.
const kMockCode = '482913';

const kAarav = TrainerMock(
  name: 'Aarav Shah',
  initials: 'AS',
  handle: 'routinelycrm.com/aarav',
  city: 'Pune',
  clientCount: 14,
  code: kMockCode,
);

const kPriya = TrainerMock(
  name: 'Priya Deshmukh',
  initials: 'PD',
  handle: 'routinelycrm.com/priya',
  city: 'Mumbai',
  clientCount: 9,
  code: '551204',
);

/// The demo phone number that resolves to a single pending invite
/// (Aarav) with prefilled client data — the "happy path" through C5/C6b.
const kDemoPhoneSingle = '98765 43210';

/// A second demo phone number that resolves to multiple pending invites,
/// so the C5b screen is reachable in the click-through without a real
/// backend. Any phone number other than this one is treated as the
/// single-invite case, so the prototype never dead-ends on an
/// unrecognized number.
const kDemoPhoneMultiple = '99999 99999';

ClientEntryPath entryPathForPhone(String digitsOnly) {
  final normalized = digitsOnly.replaceAll(RegExp(r'\s'), '');
  if (normalized == kDemoPhoneMultiple.replaceAll(' ', '')) {
    return ClientEntryPath.demoPhoneMultiple;
  }
  return ClientEntryPath.defaultPhoneSingle;
}

/// Sneha's data as Aarav already entered it for her — shown prefilled
/// ("FROM AARAV" chips) on C6b.
final kSnehaPrefill = ClientPrefillData(
  firstName: 'Sneha',
  lastName: 'Nair',
  city: 'Pune',
  dob: DateTime(1997, 3, 14),
);

/// Aarav's own profile, prefilled on T3/T4/T5 exactly as shown in the
/// design (bold/filled styling there, not placeholder styling — see plan).
class TrainerProfileDefaults {
  static const firstName = 'Aarav';
  static const lastName = 'Shah';
  static const city = 'Pune';
  static const gender = Gender.male;
  static const yearsExperience = '3–5';
  static const certifications = ['ACE Certified Personal Trainer'];
  static const specialities = {'Fat loss', 'Strength'};
  static const mode = CoachingMode.both;
  static const handle = 'aarav';
}

const kGenderOptions = Gender.values;
const kYearsOptions = ['<1', '1–3', '3–5', '5+'];
const kSpecialityOptions = [
  'Fat loss',
  'Muscle gain',
  'Strength',
  'Post-partum',
  'Sports',
  'General fitness',
];
const kCoachingModeOptions = CoachingMode.values;
const kDietOptions = Diet.values;

/// C7 body-basics defaults — prefilled (see plan point on C7 styling
/// matching the `val`-style convention used by every other prefilled
/// screen), except `injuries`, which the design renders with genuine
/// hint-text styling and so starts empty.
abstract final class BodyBasicsDefaults {
  static const heightCm = 164;
  static const weightKg = 68.4;
  static const targetWeightKg = 62.0;
  static const diet = Diet.egg;
}

const kAllTrainers = [kAarav, kPriya];
