class UserProfile {
  final String name;
  final String university;
  final String college;

  UserProfile({
    required this.name,
    required this.university,
    required this.college,
  });

  UserProfile copyWith({
    String? name,
    String? university,
    String? college,
  }) {
    return UserProfile(
      name: name ?? this.name,
      university: university ?? this.university,
      college: college ?? this.college,
    );
  }

  factory UserProfile.empty() {
    return UserProfile(name: '', university: '', college: '');
  }
}
