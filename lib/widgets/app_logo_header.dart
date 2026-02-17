import 'package:flutter/material.dart';
import 'package:lost_and_found/utils/constants.dart';

/// Shows logo.png — falls back to a hand-crafted text logo
class AppLogoHeader extends StatelessWidget {
  final double maxWidth;
  const AppLogoHeader({super.key, this.maxWidth = 250});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Image.asset(
        AppConstants.logoPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
