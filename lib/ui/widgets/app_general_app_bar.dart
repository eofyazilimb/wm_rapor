import 'package:flutter/material.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/ui/common/shared_styles.dart';

class AppGeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  // final bool? isThereMenuButton;
  // final bool? isThereNotifIcon;
  // final VoidCallback? onMenuPressed;
  // final VoidCallback? onNotificationPressed;
  final List<Widget>? actionButton;

  const AppGeneralAppBar({
    super.key,
    required this.title,
    // this.onMenuPressed,
    // this.onNotificationPressed,
    // this.isThereMenuButton,
    // this.isThereNotifIcon,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyles().ktsTitleMedium.copyWith(
          color: AppColors.kcWhite,
        ),
      ),
      // leading: isThereMenuButton ?? true
      //     ? IconButton(
      //         onPressed: onMenuPressed,
      //         icon: const Icon(
      //           Icons.menu,
      //           color: AppColors.kcWhite,
      //         ),
      //       )
      //     : null,
      actions: (actionButton != null) ? actionButton : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
