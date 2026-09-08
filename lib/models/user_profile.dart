class UserProfile {
  final String id;
  final String username;
  final String? avatarUrl;
  final DateTime birthdate;

  UserProfile({
    required this.id,
    required this.username,
    required this.birthdate,
    this.avatarUrl,
  });

  //Getter per calcolo età
  int get age {
    final today = DateTime.now();
    int age = today.year - birthdate.year;
    //verifica se il compleanno è già passato
    if (today.month < birthdate.month ||
        (today.month == birthdate.month && today.day < birthdate.day)) {
      age--;
    }
    return age;
  }

  //converto un oggetto Map del DB in un oggetto UserProfile
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      username: map['username'],
      birthdate: DateTime.parse(map['birthdate']),
      avatarUrl: map['avatar_url'],
    );
  }

  //converto un oggetto UserProfile in una Map utilizzabile dal DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'birthdate': birthdate.toIso8601String(), //salvo data con formato ISO
      'avatar_url': avatarUrl,
    };
  }
}
