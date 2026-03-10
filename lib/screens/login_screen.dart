import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/services/auth_service.dart';
import 'package:lost_and_found/utils/app_routes.dart';
import 'package:lost_and_found/utils/app_theme.dart';
import 'package:lost_and_found/utils/validators.dart';
import 'package:lost_and_found/widgets/app_logo_header.dart';
import 'package:lost_and_found/widgets/auth_link_text.dart';
import 'package:lost_and_found/widgets/auth_text_field.dart';
import 'package:lost_and_found/widgets/ncst_app_bar.dart';
import 'package:lost_and_found/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // ── Actions ──────────────────────────────────────────────────────────

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final user = await _authService.login(
        emailOrStudentNumber: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.dashboard,
          arguments: user,
        );
      }
    } on AuthException catch (e) {
      // Known auth error (student number not found, wrong password, etc.)
      _showError(e.message);
    } on FirebaseAuthException catch (e) {
      // Firebase-specific error
      _showError(e.message ?? 'Authentication failed.');
    } catch (e, stack) {
      // Log unexpected error for debugging
      debugPrint('Login error: $e');
      debugPrint('$stack');
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _forgotPassword() {
    Navigator.pushReplacementNamed(context, AppRoutes.forgotPassword);
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(msg)),
          ],
        ),
        backgroundColor: AppTheme.errorRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: const NcstAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Logo ───────────────────────────────────────────────
                const AppLogoHeader(),
                const SizedBox(height: 36),

                // ── Email / Student Number ─────────────────────────────
                AuthTextField(
                  controller: _emailCtrl,
                  label: 'NCST Email Account/Student Number',
                  hintText: 'e.g. student@ncst.edu.ph',
                  prefixIcon: Icons.person_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // ── Password ───────────────────────────────────────────
                AuthTextField(
                  controller: _passwordCtrl,
                  label: 'Password',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.textGrey,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: Validators.validatePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _login(),
                ),

                // ── Forgot password ────────────────────────────────────
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _forgotPassword,
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: AppTheme.linkColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                // ── Log In button ──────────────────────────────────────
                PrimaryButton(
                  label: 'Log In',
                  isLoading: _isLoading,
                  onPressed: _login,
                ),
                const SizedBox(height: 20),

                // ── Register link ──────────────────────────────────────
                AuthLinkText(
                  normalText: "Don't have an account? ",
                  linkText: 'Register',
                  onLinkTap: () =>
                      Navigator.pushNamed(context, AppRoutes.register),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
