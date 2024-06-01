import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';

class MainTextFieldDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final dynamic value;
  final String? hint;
  final String? label;
  final String? errorText;
  final bool isFilled;
  final Color? fillColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? dropdownPadding;
  final EdgeInsetsGeometry? contentPadding;
  final int elevation;
  final double? menuMaxHeight;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? icon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BorderType? borderType;
  final double borderWidth;
  final double borderRadius;
  final Function(T?)? onChanged;

  const MainTextFieldDropdown({
    Key? key,
    required this.items,
    this.value,
    this.hint,
    this.label,
    this.errorText,
    this.isFilled = false,
    this.fillColor,
    this.padding,
    this.dropdownPadding,
    this.contentPadding,
    this.elevation = 8,
    this.menuMaxHeight,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.icon,
    this.suffixIcon,
    this.prefixIcon,
    this.borderType = BorderType.outline,
    this.borderWidth = 1,
    this.borderRadius = 5,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    InputBorder? border;
    InputBorder? enabledBorder;
    InputBorder? focusedBorder;
    InputBorder? errorBorder;

    switch (borderType!) {
      //======================================================================== None Border
      /// "border:" in case text field has error and focused in the same time
      case BorderType.none:
        {
          border = InputBorder.none;
          enabledBorder = InputBorder.none;
          focusedBorder = InputBorder.none;
          errorBorder = InputBorder.none;
        }
        break;
      //======================================================================== Underline Border
      case BorderType.underline:
        {
          border = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: borderWidth));
          enabledBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: borderWidth));
          focusedBorder = UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColorLight, width: borderWidth));
          errorBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: borderWidth));
        }
        break;
      //======================================================================== Outline Border
      case BorderType.outline:
        {
          border = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.grey, width: borderWidth),
          );
          enabledBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.grey, width: borderWidth),
          );
          focusedBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            // borderSide: BorderSide(color: AppColors.primaryColorLight, width: borderWidth),
            borderSide: BorderSide(color: AppColors.goldColor, width: borderWidth),
          );
          errorBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.red, width: borderWidth),
          );
        }
        break;
    }

    return Padding(
      padding: dropdownPadding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: DropdownButtonFormField<T>(
        items: items,
        value: value,
        onChanged: onChanged,
        elevation: elevation,
        padding: padding,
        isExpanded: true,
        isDense: true,
        borderRadius: BorderRadius.circular(borderRadius),
        menuMaxHeight: menuMaxHeight,
        style: style ?? const TextStyle(fontSize: 14),
        icon: icon ?? const Icon(Icons.keyboard_arrow_down),
        decoration: InputDecoration(
          // contentPadding:contentPadding?? const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          filled: isFilled,
          fillColor: fillColor,
          hintText: hint,
          hintStyle: hintStyle ?? const TextStyle(fontSize: 14),
          labelText: label,
          labelStyle: labelStyle ?? const TextStyle(fontSize: 14),
          errorText: errorText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: border, // in case text field has error and focused in the same time
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          disabledBorder: enabledBorder,
          focusedErrorBorder: errorBorder,
        ),
        validator: (value) {
          return value != null ? null : locale.get("Required");
        },
      ),
    );
  }
}
