import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/ui/common/shared_styles.dart';
import 'package:wm_rapor/ui/common/ui_helpers.dart';

class AppGeneralTextField extends StatelessWidget {
  final bool? enabled;
  final String? hintText;
  final Color? tfFillColor;
  final bool? tfFilled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final BorderSide? disabledBorderSide;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool obscureText;
  final TextInputAction? textInputAction;
  const AppGeneralTextField({
    super.key,
    this.enabled,
    this.hintText,
    this.tfFilled,
    this.tfFillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.borderRadius,
    this.disabledBorderSide,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.hintStyle,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
    this.focusNode,
    this.maxLines,
    this.obscureText = false,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: obscureText ? 1 : maxLines,
      cursorColor: AppColors.kcPrimaryColor,
      cursorErrorColor: AppColors.kcPrimaryColor,
      focusNode: focusNode,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        // contentPadding: contentPadding ?? AppSpacing.allMedium,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        errorBorder: OutlineInputBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(UiHelpers.borderRadius),
          borderSide:
              disabledBorderSide ?? UiHelpers.appGeneralTfErrorBorderSide,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(UiHelpers.borderRadius),
          borderSide: disabledBorderSide ?? UiHelpers.appGeneralTfBorderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(UiHelpers.borderRadius),
          borderSide: enabledBorderSide ?? UiHelpers.appGeneralTfBorderSide,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(UiHelpers.borderRadius),
          borderSide:
              disabledBorderSide ?? UiHelpers.appGeneralTfErrorBorderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(UiHelpers.borderRadius),
          borderSide:
              focusedBorderSide ?? UiHelpers.appGeneralTfFocusedBorderSide,
        ),
        hintText: hintText ?? '',
        hintStyle:
            hintStyle ??
            AppTextStyles().ktsBodyMedium.copyWith(color: AppColors.kcBlueGray),
        fillColor: tfFillColor ?? AppColors.kcWhite,
        filled: tfFilled ?? true,
      ),
    );
  }
}
