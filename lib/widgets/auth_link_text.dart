import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/utils/app_theme.dart';

/// Inline tappable link.  e.g. "Don't have an account? [Register]"
class AuthLinkText extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onLinkTap;

  const AuthLinkText({
    super.key,
    required this.normalText,
    required this.linkText,
    required this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: normalText,
            style: const TextStyle(fontSize: 14, color: AppTheme.textGrey),
          ),
          TextSpan(
            text: linkText,
            recognizer: TapGestureRecognizer()..onTap = onLinkTap,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.linkColor,
              decoration: TextDecoration.underline,
              decorationColor: AppTheme.linkColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}