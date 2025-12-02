import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wm_rapor/ui/common/shared_styles.dart';
import 'package:wm_rapor/ui/common/ui_helpers.dart';

class InfoMessageWidget extends StatelessWidget {
  final String svgPicture;
  final String? title;
  final String? subtitle;
  const InfoMessageWidget({
    super.key,
    required this.svgPicture,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: AppSpacing.screenHeight(context) * .17),
          SvgPicture.asset(
            package: 'wm_rapor',
            svgPicture,
            height: AppSpacing.screenHeight(context) * .20,
          ),
          AppSpacing.verticalSpaceLarge,
          Text(title ?? '', style: AppTextStyles().ktsTitleMedium),
          AppSpacing.verticalSpaceTiny,
          Text(subtitle ?? '', style: AppTextStyles().ktsBodyMedium),
        ],
      ),
    );
  }
}
