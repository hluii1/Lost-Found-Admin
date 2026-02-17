// services/auth_service.dart
//
// Handles Firebase Authentication only.
// No Firestore / database calls.
//
// To activate Firebase:
//   1. Run: flutterfire configure
//   2. Uncomment the firebase_auth imports and real implementations below.
//   3. Comment out / remove the stub section.

import 'package:lost_and_found/models/user_model.dart';

// ── Uncomment after flutterfire configure ────────────────────────────────
// import 'package:firebase_auth/firebase_auth.dart';
// ─────────────────────────────────────────────────────────────────────────

class AuthService {
  // Singleton
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;
  AuthService._();

  // ── Uncomment after flutterfire configure ──────────────────────────────
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // ─────────────────────────────────────────────────────────────────────--

  // In-memory current user (replaced by FirebaseAuth.currentUser in production)
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // ══════════════════════════════════════════════════════════════════════
  // LOGIN
  // ══════════════════════════════════════════════════════════════════════

  /// Sign in with NCST email (or student number) and password.
  /// Returns a [UserModel] on success; throws [AuthException] on failure.
  Future<UserModel> login({
    required String emailOrStudentNumber,
    required String password,
  }) async {
    // ── REAL Firebase implementation ──────────────────────────────────
    // try {
    //   // If user typed a student number, resolve it to the stored email first.
    //   // (You would look this up from Firestore or a Cloud Function.)
    //   final email = emailOrStudentNumber.contains('@')
    //       ? emailOrStudentNumber
    //       : await _resolveStudentNumberToEmail(emailOrStudentNumber);
    //
    //   final credential = await _auth.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //
    //   final fbUser = credential.user!;
    //   _currentUser = UserModel(
    //     uid:           fbUser.uid,
    //     surname:       '',            // fetch from Firestore if needed
    //     firstName:     fbUser.displayName ?? '',
    //     studentNumber: '',            // fetch from Firestore if needed
    //     ncstEmail:     fbUser.email ?? '',
    //   );
    //   return _currentUser!;
    // } on FirebaseAuthException catch (e) {
    //   throw AuthException(_mapFirebaseError(e.code));
    // }
    // ─────────────────────────────────────────────────────────────────

    // ── STUB (remove when Firebase is active) ─────────────────────────
    await Future.delayed(const Duration(milliseconds: 800));

    if (emailOrStudentNumber.trim().isEmpty || password.isEmpty) {
      throw const AuthException('Email/student number and password are required.');
    }
    if (password.length < 6) {
      throw const AuthException('Incorrect email or password.');
    }

    _currentUser = UserModel(
      uid:           'stub-uid-001',
      surname:       'Dela Cruz',
      firstName:     'Juan',
      studentNumber: '2021-00001',
      ncstEmail:     emailOrStudentNumber.contains('@')
          ? emailOrStudentNumber.trim()
          : '2021-00001@ncst.edu.ph',
    );
    return _currentUser!;
    // ─────────────────────────────────────────────────────────────────
  }

  // ══════════════════════════════════════════════════════════════════════
  // REGISTER
  // ══════════════════════════════════════════════════════════════════════

  /// Create a new Firebase Auth account and return a [UserModel].
  Future<UserModel> register({
    required String surname,
    required String firstName,
    required String studentNumber,
    required String ncstEmail,
    required String password,
  }) async {
    // ── REAL Firebase implementation ──────────────────────────────────
    // try {
    //   final credential = await _auth.createUserWithEmailAndPassword(
    //     email: ncstEmail,
    //     password: password,
    //   );
    //
    //   await credential.user!.updateDisplayName('$firstName $surname');
    //
    //   _currentUser = UserModel(
    //     uid:           credential.user!.uid,
    //     surname:       surname,
    //     firstName:     firstName,
    //     studentNumber: studentNumber,
    //     ncstEmail:     ncstEmail,
    //   );
    //   return _currentUser!;
    // } on FirebaseAuthException catch (e) {
    //   throw AuthException(_mapFirebaseError(e.code));
    // }
    // ─────────────────────────────────────────────────────────────────

    // ── STUB (remove when Firebase is active) ─────────────────────────
    await Future.delayed(const Duration(milliseconds: 800));

    _currentUser = UserModel(
      uid:           'stub-uid-new',
      surname:       surname,
      firstName:     firstName,
      studentNumber: studentNumber,
      ncstEmail:     ncstEmail,
    );
    return _currentUser!;
    // ─────────────────────────────────────────────────────────────────
  }

  // ══════════════════════════════════════════════════════════════════════
  // SIGN OUT
  // ══════════════════════════════════════════════════════════════════════

  Future<void> signOut() async {
    // await _auth.signOut();          // uncomment for Firebase
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  // ══════════════════════════════════════════════════════════════════════
  // FORGOT PASSWORD
  // ══════════════════════════════════════════════════════════════════════

  Future<void> sendPasswordReset(String email) async {
    // await _auth.sendPasswordResetEmail(email: email);  // uncomment for Firebase
    await Future.delayed(const Duration(milliseconds: 600));
    if (email.trim().isEmpty) {
      throw const AuthException('Please enter your email address.');
    }
  }

  // ══════════════════════════════════════════════════════════════════════
  // HELPERS
  // ══════════════════════════════════════════════════════════════════════

  // Maps Firebase error codes to user-friendly messages.
  // String _mapFirebaseError(String code) {
  //   switch (code) {
  //     case 'user-not-found':
  //     case 'wrong-password':
  //       return 'Incorrect email or password.';
  //     case 'email-already-in-use':
  //       return 'This email is already registered.';
  //     case 'weak-password':
  //       return 'Password is too weak. Use at least 8 characters.';
  //     case 'invalid-email':
  //       return 'Invalid email address.';
  //     case 'too-many-requests':
  //       return 'Too many attempts. Please try again later.';
  //     case 'network-request-failed':
  //       return 'No internet connection.';
  //     default:
  //       return 'An error occurred. Please try again.';
  //   }
  // }
}

// ══════════════════════════════════════════════════════════════════════════
// AUTH EXCEPTION
// ══════════════════════════════════════════════════════════════════════════

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}