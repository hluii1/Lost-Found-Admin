class UserModel {
  final String uid;
  final String surname;
  final String firstName;
  final String studentNumber;
  final String ncstEmail;
  final String role;

  const UserModel({
    required this.uid,
    required this.surname,
    required this.firstName,
    required this.studentNumber,
    required this.ncstEmail,
    this.role = 'user',
  });

  String get fullName => '$firstName $surname';
  String get initials => '${firstName[0]}${surname[0]}'.toUpperCase();

  bool get isAdmin => role == 'admin';

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
        uid: m['uid'] as String? ?? '',
        surname: m['surname'] as String? ?? '',
        firstName: m['firstName'] as String? ?? '',
        studentNumber: m['studentNumber'] as String? ?? '',
        ncstEmail: m['ncstEmail'] as String? ?? '',
        role: m['role'] as String? ?? 'user',
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'surname': surname,
        'firstName': firstName,
        'studentNumber': studentNumber,
        'ncstEmail': ncstEmail,
        'role': role,
      };

  UserModel copyWith({
    String? uid,
    String? surname,
    String? firstName,
    String? studentNumber,
    String? ncstEmail,
    String? role,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        surname: surname ?? this.surname,
        firstName: firstName ?? this.firstName,
        studentNumber: studentNumber ?? this.studentNumber,
        ncstEmail: ncstEmail ?? this.ncstEmail,
        role: role ?? this.role,
      );

  @override
  String toString() => 'UserModel($fullName | $studentNumber | $ncstEmail)';
}
