import 'package:flutter/material.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/ui/common/shared_styles.dart';
import 'package:wm_rapor/ui/common/util/string_util.dart';

class InformationBar extends StatelessWidget {
  final String text;
  final Color? color;
  const InformationBar({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? AppColors.kcSecondaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: effectiveColor.withValues(alpha: .20),
      ),
      child: Text(
        StringUtil.toUpperCaseString(text),
        style: AppTextStyles().ktsBodyVerySmall.copyWith(color: effectiveColor),
      ),
    );
  }
}
