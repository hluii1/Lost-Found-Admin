import 'package:flutter/material.dart';
import 'package:lost_and_found/utils/app_theme.dart';
import 'package:lost_and_found/utils/constants.dart';

class NcstAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NcstAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 64,
      titleSpacing: 20,
      title: Row(
        children: [
          Image.asset(
            AppConstants.lfNcstLogoPath,
            height: 30,
          ),
          const SizedBox(width: 10),
          const Text(
            AppConstants.appName,
            style: TextStyle(
              color: AppTheme.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppTheme.borderColor.withOpacity(0.25)),
      ),
    );
  }
}