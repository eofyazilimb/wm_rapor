import 'package:flutter/material.dart';
import 'package:wm_rapor/model/report_list_model.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/ui/common/shared_styles.dart';
import 'package:wm_rapor/ui/common/ui_helpers.dart';
import 'package:wm_rapor/ui/views/report_view.dart';

class ReportItem extends StatelessWidget {
  final ReportListModel report;
  const ReportItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.smallSize),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiHelpers.borderRadius),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportScreen(reportId: report.id!),
            ),
          );
        },
        child: Ink(
          decoration: UiHelpers.appGeneralBoxDecoration.copyWith(
            color: AppColors.kcWhite,
            border: UiHelpers.appContainerBoxBorder,
          ),
          padding: AppSpacing.allSmall,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     InformationBar(
              //       text: '',
              //       color: AppColors.kcPurple,
              //     ),                ],
              // ),
              // AppSpacing.verticalSpaceTiny,
              Text(
                report.tanim ?? '',
                style: AppTextStyles().ktsBodySmall.copyWith(
                  color: AppColors.kcPrimaryColor,
                ),
              ),
              AppSpacing.verticalSpaceTiny,
              Text(
                report.aciklama ?? '',
                // einv.aliciunvan ?? '',
                // einv.cariunvan ?? '',
                style: AppTextStyles().ktsBodyVerySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
