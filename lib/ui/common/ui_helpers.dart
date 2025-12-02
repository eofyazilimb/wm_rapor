import 'package:flutter/material.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';

class UiHelpers {
  static const double borderRadiusTabBar = 30.0;
  static const double borderRadius = 14.0;
  static const double borderRadiusSmall = 7.0;

  static const BorderSide appGeneralTfBorderSide = BorderSide(
    color: AppColors.kcLightGray,
  );
  static const BorderSide appGeneralTfErrorBorderSide = BorderSide(
    color: AppColors.kcRed,
  );
  static const BorderSide appGeneralTfFocusedBorderSide = BorderSide(
    color: AppColors.kcPrimaryColor,
  );
  static BoxBorder appContainerBoxBorder = Border.all(
    color: AppColors.kcLightGray,
  );
  static BoxBorder containerSuccessBoxBorder = Border.all(
    color: AppColors.kcGreen,
  );
  static BoxBorder containerErrorBoxBorder = Border.all(color: AppColors.kcRed);
  static BoxBorder containerInformationBoxBorder = Border.all(
    color: AppColors.kcYellow,
  );
  static Border appContainerBorder = Border.all(
    color: AppColors.kcLightGray,
    width: 2,
  );
  static BoxDecoration appContainerCircleDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: UiHelpers.appContainerBoxBorder,
    color: AppColors.kcWhite,
  );
  static BoxDecoration appGeneralBoxDecoration = BoxDecoration(
    border: UiHelpers.appContainerBoxBorder,
    borderRadius: BorderRadius.circular(UiHelpers.borderRadius),
    color: AppColors.kcVeryLightGray,
  );
  static BoxDecoration appGeneralIconBoxDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: AppColors.kcWhite.withValues(alpha: .25),
        offset: const Offset(0, 0),
        blurRadius: 16,
        spreadRadius: 0,
      ),
    ],
  );

  static BoxShadow appGeneralShadow({double? dx, double? dy}) {
    return BoxShadow(
      color: AppColors.kcPrimaryColor.withValues(alpha: .25),
      offset: Offset(dx ?? 0, dy ?? 4),
      blurRadius: 4,
      spreadRadius: -2,
    );
  }

  static const double iconSize16 = 16.0;
  static const double iconSize24 = 24.0;
  static const double bottomNavBarIconSizeResponsive = 20.0;
  static const double bottomNavBarIconSize = 28.0;
  static const double bottomNavBarSizeResponsive = 50.0;
  static const double bottomNavBarSize = 60.0;
  static const double bottomNavBarMiddleItemSizeResponsive = 60.0;
  static const double bottomNavBarMiddleItemSize = 70.0;

  static const double indicatorDotHeight = 8.0;
  static const double indicatorDotWidth = 8.0;
}

class AppSpacing {
  static const double tinySize = 4.0;
  static const double smallSize = 8.0;
  static const double mediumSize = 16.0;
  static const double largeSize = 24.0;
  static const double veryLargeSize = 32.0;

  static const EdgeInsets allTiny = EdgeInsets.all(tinySize);
  static const EdgeInsets allSmall = EdgeInsets.all(smallSize);
  static const EdgeInsets allMedium = EdgeInsets.all(mediumSize);
  static const EdgeInsets allLarge = EdgeInsets.all(largeSize);
  static const EdgeInsets allVeryLarge = EdgeInsets.all(veryLargeSize);

  static const EdgeInsets symmetricHorizontalTiny = EdgeInsets.symmetric(
    horizontal: tinySize,
  );
  static const EdgeInsets symmetricHorizontalSmall = EdgeInsets.symmetric(
    horizontal: smallSize,
  );
  static const EdgeInsets symmetricHorizontalMedium = EdgeInsets.symmetric(
    horizontal: mediumSize,
  );
  static const EdgeInsets symmetricHorizontalLarge = EdgeInsets.symmetric(
    horizontal: largeSize,
  );
  static const EdgeInsets symmetricHorizontalVeryLarge = EdgeInsets.symmetric(
    horizontal: veryLargeSize,
  );

  static const EdgeInsets symmetricVerticalTiny = EdgeInsets.symmetric(
    vertical: tinySize,
  );
  static const EdgeInsets symmetricVerticalSmall = EdgeInsets.symmetric(
    vertical: smallSize,
  );
  static const EdgeInsets symmetricVerticalMedium = EdgeInsets.symmetric(
    vertical: mediumSize,
  );
  static const EdgeInsets symmetricVerticalLarge = EdgeInsets.symmetric(
    vertical: largeSize,
  );
  static const EdgeInsets symmetricVerticalVeryLarge = EdgeInsets.symmetric(
    vertical: veryLargeSize,
  );

  static const EdgeInsets pagePaddingWithoutAppBar = EdgeInsets.only(
    top: AppSpacing.veryLargeSize,
    left: AppSpacing.mediumSize,
    right: AppSpacing.mediumSize,
  );

  static const EdgeInsets listPaddingWithoutbottom = EdgeInsets.only(
    top: AppSpacing.mediumSize,
    left: AppSpacing.mediumSize,
    right: AppSpacing.mediumSize,
  );

  static const Widget horizontalSpaceTiny = SizedBox(width: tinySize);
  static const Widget horizontalSpaceSmall = SizedBox(width: smallSize);
  static const Widget horizontalSpaceMedium = SizedBox(width: mediumSize);
  static const Widget horizontalSpaceLarge = SizedBox(width: largeSize);
  static const Widget horizontalSpaceVeryLarge = SizedBox(width: veryLargeSize);

  static const Widget verticalSpaceTiny = SizedBox(height: tinySize);
  static const Widget verticalSpaceSmall = SizedBox(height: smallSize);
  static const Widget verticalSpaceMedium = SizedBox(height: mediumSize);
  static const Widget verticalSpaceLarge = SizedBox(height: largeSize);
  static const Widget verticalSpaceVeryLarge = SizedBox(height: veryLargeSize);

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
