class UserModel {
  final String  uid;
  final String  surname;
  final String  firstName;
  final String  studentNumber;
  final String  ncstEmail;

  const UserModel({
    required this.uid,
    required this.surname,
    required this.firstName,
    required this.studentNumber,
    required this.ncstEmail,
  });

  String get fullName    => '$firstName $surname';
  String get initials    => '${firstName[0]}${surname[0]}'.toUpperCase();

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
        uid:           m['uid']           as String? ?? '',
        surname:       m['surname']       as String? ?? '',
        firstName:     m['firstName']     as String? ?? '',
        studentNumber: m['studentNumber'] as String? ?? '',
        ncstEmail:     m['ncstEmail']     as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        'uid':           uid,
        'surname':       surname,
        'firstName':     firstName,
        'studentNumber': studentNumber,
        'ncstEmail':     ncstEmail,
      };

  UserModel copyWith({
    String? uid,
    String? surname,
    String? firstName,
    String? studentNumber,
    String? ncstEmail,
  }) =>
      UserModel(
        uid:           uid           ?? this.uid,
        surname:       surname       ?? this.surname,
        firstName:     firstName     ?? this.firstName,
        studentNumber: studentNumber ?? this.studentNumber,
        ncstEmail:     ncstEmail     ?? this.ncstEmail,
      );

  @override
  String toString() => 'UserModel($fullName | $studentNumber | $ncstEmail)';
}