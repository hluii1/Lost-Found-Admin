class AppConstants {
  // App Info
  static const String appName = 'Lost & Found';
  static const String appVersion = '1.0.0';
  static const String schoolName = 'NCST';
  static const String schoolFullName =
      'National College of Science and Technology';

   // Asset paths
  static const String logoPath        = 'assets/images/logo.png';
  static const String lfNcstLogoPath  = 'assets/images/lf_ncst_logo.png';
  static const String splashLogoPath  = 'assets/images/splash_screen_logo.png';

  // Validation
  static const int minPasswordLength = 8;
  static const String ncstEmailDomain = '@ncst.edu.ph';

  // Error Messages
  static const String emptyFieldError = 'This field cannot be empty';
  static const String invalidEmailError =
      'Please enter a valid NCST email address';
  static const String passwordLengthError =
      'Password must be at least $minPasswordLength characters';
  static const String passwordMatchError = 'Passwords do not match';
  static const String invalidStudentNumberError =
      'Please enter a valid student number';

  // Hint Texts
  static const String emailHint = 'e.g. student@ncst.edu.ph';
  static const String studentNumberHint = 'e.g. 2021-00001';
  static const String surnameHint = 'Last name';
  static const String firstNameHint = 'First name';
  static const String passwordHint = '••••••••';
  static const String confirmPasswordHint = '••••••••';
}