import 'package:flutter/material.dart';
import 'package:lost_and_found/services/auth_service.dart';
import 'package:lost_and_found/utils/app_routes.dart';
import 'package:lost_and_found/utils/app_theme.dart';
import 'package:lost_and_found/utils/validators.dart';
import 'package:lost_and_found/widgets/app_logo_header.dart';
import 'package:lost_and_found/widgets/auth_link_text.dart';
import 'package:lost_and_found/widgets/auth_text_field.dart';
import 'package:lost_and_found/widgets/ncst_app_bar.dart';
import 'package:lost_and_found/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey              = GlobalKey<FormState>();
  final _surnameCtrl          = TextEditingController();
  final _firstNameCtrl        = TextEditingController();
  final _studentNumCtrl       = TextEditingController();
  final _emailCtrl            = TextEditingController();
  final _passwordCtrl         = TextEditingController();
  final _confirmPasswordCtrl  = TextEditingController();
  final _authService          = AuthService();

  bool _isLoading             = false;
  bool _obscurePassword       = true;
  bool _obscureConfirm        = true;

  @override
  void dispose() {
    _surnameCtrl.dispose();
    _firstNameCtrl.dispose();
    _studentNumCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  // ── Actions ──────────────────────────────────────────────────────────

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final user = await _authService.register(
        surname:       _surnameCtrl.text.trim(),
        firstName:     _firstNameCtrl.text.trim(),
        studentNumber: _studentNumCtrl.text.trim(),
        ncstEmail:     _emailCtrl.text.trim(),
        password:      _passwordCtrl.text,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.dashboard,
          arguments: user,
        );
      }
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Registration failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
                const SizedBox(height: 28),

                // ── Surname + First Name ───────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: AuthTextField(
                        controller: _surnameCtrl,
                        label: 'Surname',
                        hintText: 'Last name',
                        prefixIcon: Icons.badge_outlined,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => Validators.validateRequired(
                            v, fieldName: 'Surname'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AuthTextField(
                        controller: _firstNameCtrl,
                        label: 'First Name',
                        hintText: 'First name',
                        prefixIcon: Icons.person_outline_rounded,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => Validators.validateRequired(
                            v, fieldName: 'First Name'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Student Number ─────────────────────────────────────
                AuthTextField(
                  controller: _studentNumCtrl,
                  label: 'Student Number',
                  hintText: 'e.g. 2021-00001',
                  prefixIcon: Icons.numbers_rounded,
                  validator: Validators.validateStudentNumber,
                ),
                const SizedBox(height: 14),

                // ── NCST Email ─────────────────────────────────────────
                AuthTextField(
                  controller: _emailCtrl,
                  label: 'NCST Email Account',
                  hintText: 'student@ncst.edu.ph',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 14),

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
                ),
                const SizedBox(height: 14),

                // ── Confirm Password ───────────────────────────────────
                AuthTextField(
                  controller: _confirmPasswordCtrl,
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
                  onFieldSubmitted: (_) => _register(),
                ),
                const SizedBox(height: 24),

                // ── Register button ────────────────────────────────────
                PrimaryButton(
                  label: 'Register',
                  isLoading: _isLoading,
                  onPressed: _register,
                ),
                const SizedBox(height: 16),

                // ── Login link ─────────────────────────────────────────
                AuthLinkText(
                  normalText: 'Already have an account? ',
                  linkText: 'Login',
                  onLinkTap: () =>
                      Navigator.pushReplacementNamed(context, AppRoutes.login),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}