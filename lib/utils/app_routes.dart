import 'package:flutter/material.dart';
import 'package:lost_and_found/screens/splash_screen.dart';
import 'package:lost_and_found/screens/login_screen.dart';
import 'package:lost_and_found/screens/register_screen.dart';
import 'package:lost_and_found/screens/dashboard_screen.dart';
import 'package:lost_and_found/screens/forgot_password_screen.dart';
import 'package:lost_and_found/screens/reset_password_screen.dart';
import 'package:lost_and_found/models/user_model.dart';

class AppRoutes {
  static const String splash         = '/';
  static const String login          = '/login';
  static const String register       = '/register';
  static const String dashboard      = '/dashboard';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword  = '/reset-password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fade(const SplashScreen());

      case login:
        return _fade(const LoginScreen());

      case register:
        return _fade(const RegisterScreen());

      case dashboard:
        final user = settings.arguments as UserModel?;
        return _fade(DashboardScreen(user: user));

      case forgotPassword:
        return _fade(const ForgotPasswordScreen());

      case resetPassword:
        return _fade(const ResetPasswordScreen());

      default:
        return _fade(Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }

  static PageRouteBuilder _fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 250),
    );
  }
}