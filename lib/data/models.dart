enum Gender { male, female, preferNotToSay }

extension GenderLabel on Gender {
  String get label => switch (this) {
    Gender.male => 'Male',
    Gender.female => 'Female',
    Gender.preferNotToSay => 'Prefer not to say',
  };
}

enum Diet { veg, egg, nonVeg }

extension DietLabel on Diet {
  String get label => switch (this) {
    Diet.veg => 'Veg',
    Diet.egg => 'Egg',
    Diet.nonVeg => 'Non-veg',
  };
}

enum CoachingMode { online, inPerson, both }

extension CoachingModeLabel on CoachingMode {
  String get label => switch (this) {
    CoachingMode.online => 'Online',
    CoachingMode.inPerson => 'In-person',
    CoachingMode.both => 'Both',
  };
}

/// How a client arrived at the "connected" step — decides whether the
/// following profile step (C6/C6b) is prefilled by the trainer or empty.
/// Trainer-code entry always resolves to a single trainer too, but must
/// NOT prefill (no pre-existing client record), so the entry path (not
/// the matched-trainer count) is what the profile step branches on.
enum ClientEntryPath { defaultPhoneSingle, demoPhoneMultiple, trainerCode }

class TrainerMock {
  const TrainerMock({
    required this.name,
    required this.initials,
    required this.handle,
    required this.city,
    required this.clientCount,
    required this.code,
  });

  final String name;
  final String initials;
  final String handle;
  final String city;
  final int clientCount;
  final String code;
}

/// Fields a trainer has already filled in on a client's behalf before
/// the client ever opens the app (C6b's "FROM AARAV" prefill state).
class ClientPrefillData {
  const ClientPrefillData({
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.dob,
  });

  final String firstName;
  final String lastName;
  final String city;
  final DateTime dob;
}
