import 'package:flutter/material.dart';
import 'package:lost_and_found/services/auth_service.dart';
import 'package:lost_and_found/utils/app_routes.dart';
import 'package:lost_and_found/utils/app_theme.dart';
import 'package:lost_and_found/utils/validators.dart';
import 'package:lost_and_found/widgets/app_logo_header.dart';
import 'package:lost_and_found/widgets/auth_text_field.dart';
import 'package:lost_and_found/widgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey          = GlobalKey<FormState>();
  final _codeCtrl         = TextEditingController();
  final _passwordCtrl     = TextEditingController();
  final _confirmCtrl      = TextEditingController();
  final _auth             = AuthService();

  bool _isLoading         = false;
  bool _obscurePassword   = true;
  bool _obscureConfirm    = true;

  // Email passed from ForgotPasswordScreen via route arguments
  String _email = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is String) _email = arg;
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      // ── REAL Firebase implementation ────────────────────────────────
      // Firebase email link flow does NOT use a manual code.
      // The reset link sent to the user's email handles verification.
      // When they click the link, use:
      //   await FirebaseAuth.instance.confirmPasswordReset(
      //     code: _codeCtrl.text.trim(),   // oobCode from the deep link
      //     newPassword: _passwordCtrl.text,
      //   );
      // ────────────────────────────────────────────────────────────────

      // ── STUB ─────────────────────────────────────────────────────────
      await Future.delayed(const Duration(milliseconds: 800));
      // Simulated success — in production the code must match Firebase oobCode
      // ─────────────────────────────────────────────────────────────────

      if (mounted) {
        _showSuccess('Password reset successful! Please log in.');
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Failed to reset password. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resendCode() async {
    if (_email.isEmpty) {
      _showError('No email address found. Please go back and try again.');
      return;
    }
    try {
      await _auth.sendPasswordReset(_email);
      _showSuccess('A new code has been sent to $_email');
    } on AuthException catch (e) {
      _showError(e.message);
    }
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(msg)),
        ]),
        backgroundColor: AppTheme.errorRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showSuccess(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(msg)),
        ]),
        backgroundColor: AppTheme.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Logo ────────────────────────────────────────────────
                const Center(child: AppLogoHeader()),
                const SizedBox(height: 32),

                // ── Title ────────────────────────────────────────────────
                const Text(
                  'Reset Your Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 10),

                // Show email it was sent to if available
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textGrey,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: "Please enter the code  we've just emailed you to reset your password.",
                      ),
                      if (_email.isNotEmpty) ...[
                        const TextSpan(text: '\n\nSent to: '),
                        TextSpan(
                          text: _email,
                          style: const TextStyle(
                            color: AppTheme.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Verification Code ─────────────────────────────────────
                AuthTextField(
                  controller: _codeCtrl,
                  label: 'Verification Code',
                  hintText: 'Enter the code from your email',
                  prefixIcon: Icons.pin_outlined,
                  keyboardType: TextInputType.number,
                  validator: (v) => Validators.validateRequired(
                      v, fieldName: 'Verification code'),
                ),
                const SizedBox(height: 14),

                // ── New Password ──────────────────────────────────────────
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
                ),
                const SizedBox(height: 14),

                // ── Confirm Password ──────────────────────────────────────
                AuthTextField(
                  controller: _confirmCtrl,
                  label: 'Confirm Password',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_reset_outlined,
                  obscureText: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.textGrey,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (v) => Validators.validateConfirmPassword(
                      v, _passwordCtrl.text),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 12),

                // ── Resend Code link ──────────────────────────────────────
                GestureDetector(
                  onTap: _resendCode,
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(
                      color: AppTheme.linkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: AppTheme.linkColor,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Submit button ─────────────────────────────────────────
                PrimaryButton(
                  label: 'Submit',
                  isLoading: _isLoading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}