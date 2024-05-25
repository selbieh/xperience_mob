import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

enum Validator {
  required,
  name,
  username,
  email,
  phone,
  password,
  number,
  isMatch,
  minLength,
  maxLength,
}

enum BorderType {
  none,
  underline,
  outline,
}

class MainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final Widget? icon;
  final bool isObscure;
  final bool isReadOnly;
  final bool? enableInteractiveSelection;
  final bool isAutofocus;
  final bool isFilled;
  final bool isDense;
  final Color? fillColor;
  final Color? cursorColor;
  final int maxLines;
  final double letterSpacing;
  final double borderRadius;
  final double borderWidth;
  final BorderType? borderType;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final String? matchedValue;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextInputAction textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Validator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onTap;
  final Function(String? x)? onChanged;
  final Function(String? x)? onFieldSubmitted;

  const MainTextField({
    required this.controller,
    this.hint,
    this.label,
    this.icon,
    this.isObscure = false,
    this.isReadOnly = false,
    this.isAutofocus = false,
    this.isFilled = false,
    this.isDense = false,
    this.enableInteractiveSelection,
    this.fillColor,
    this.cursorColor = AppColors.primaryColorDark,
    this.maxLines = 1,
    this.letterSpacing = 0,
    this.borderRadius = 5,
    this.borderWidth = 1,
    this.borderType = BorderType.outline,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.matchedValue,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.textInputAction = TextInputAction.next,
    this.contentPadding,
    this.validator,
    this.inputFormatters,
    this.textDirection,
    this.onTapOutside,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    Key? key,
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
          border = this.border ?? InputBorder.none;
          enabledBorder = this.enabledBorder ?? InputBorder.none;
          focusedBorder = this.focusedBorder ?? InputBorder.none;
          errorBorder = this.errorBorder ?? InputBorder.none;
        }
        break;
      //======================================================================== Underline Border
      case BorderType.underline:
        {
          border = this.border ?? UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: borderWidth));
          enabledBorder = this.enabledBorder ?? UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: borderWidth));
          focusedBorder = this.focusedBorder ?? UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColorLight, width: borderWidth));
          errorBorder = this.errorBorder ?? UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: borderWidth));
        }
        break;
      //======================================================================== Outline Border
      case BorderType.outline:
        {
          border = this.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey, width: borderWidth),
              );
          enabledBorder = this.enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey, width: borderWidth),
              );
          focusedBorder = this.focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                // borderSide: BorderSide(color: AppColors.primaryColorLight, width: borderWidth),
                borderSide: BorderSide(color: AppColors.goldColor2, width: borderWidth),
              );
          errorBorder = this.errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.red, width: borderWidth),
              );
        }
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        cursorWidth: 1.5,
        cursorColor: cursorColor,
        cursorRadius: const Radius.circular(5),
        obscureText: isObscure,
        readOnly: isReadOnly,
        enableInteractiveSelection: enableInteractiveSelection,
        keyboardType: keyboardType,
        style: textStyle ?? TextStyle(fontSize: 14, letterSpacing: letterSpacing),
        maxLines: maxLines,
        autofocus: isAutofocus,
        focusNode: focusNode,
        textInputAction: textInputAction,
        textAlign: textAlign!,
        textDirection: textDirection,
        obscuringCharacter: "●",
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          isDense: isDense,
          filled: isFilled,
          fillColor: fillColor,
          focusColor: Colors.teal,
          icon: icon,
          hintText: hint,
          labelText: label,
          errorText: errorText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: border,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          errorMaxLines: 2,
        ),
        validator: (value) {
          switch (validator) {
            ///============================================================================= [ Required ]
            case Validator.required:
              if (value!.trim().isEmpty) {
                return locale.get("Required");
              }
              return null;

            ///============================================================================= [ Name ]
            case Validator.name:
              RegExp regExp = RegExp(
                r"^(?=.{1,32}$)(?![._-\s])(?![0-9])[a-zA-Z0-9._-\s]+(?<![])$",
              );
              if (value!.trim().isEmpty) {
                return locale.get("Please enter your name");
              } else if (value.length < 3) {
                return locale.get("Name should be at least 3 characters");
              } else if (value.length > 32) {
                return locale.get("Name should be at most 32 characters");
              } else if (!regExp.hasMatch(value)) {
                return locale.get("Please enter valid name");
              }
              return null;

            ///============================================================================= [ Username ]
            case Validator.username:
              RegExp regExp = RegExp(
                r"^(?=.{3,32}$)(?![._-])(?![0-9])(?!.*[._-]{2})[a-zA-Z0-9._-]+(?<![._-])$",
              );
              if (value!.trim().isEmpty) {
                return locale.get("Please enter your username");
              } else if (value.length < 3) {
                return locale.get("Username should be at least 3 characters");
              } else if (value.length > 32) {
                return locale.get("Username should be at most 32 characters");
              } else if (!regExp.hasMatch(value)) {
                return locale.get("Please enter valid username");
              }
              return null;

            ///============================================================================= [ Email ]
            case Validator.email:
              RegExp regExp = RegExp(
                r"^(?=.{5,45}$)(?!.*[._]{2})(?![._])([a-zA-Z0-9._]+)@(?!.*[._]{2})([a-zA-Z0-9._]+(?<![._]))\.([a-zA-Z]{2,5})$",
              );
              if (value!.trim().isEmpty) {
                return locale.get("Please enter email address");
              } else if (!regExp.hasMatch(value)) {
                return locale.get("Please enter valid email address");
              }
              return null;

            ///============================================================================= [ Phone ]
            case Validator.phone:
              RegExp regExp = RegExp(r'(^(?:[+0])?[0-9]{8,14}$)');
              if (value!.trim().isEmpty) {
                return locale.get("Please enter phone number");
              } else if (!regExp.hasMatch(value)) {
                return locale.get("Please enter valid phone number");
              }
              return null;

            ///============================================================================= [ Number ]
            case Validator.number:
              double? number = double.tryParse(value!);
              if (value.trim().isEmpty) {
                return locale.get("Required");
              } else if (number == null) {
                return locale.get("Please enter valid number");
              }
              return null;

            ///============================================================================= [ Password ]
            case Validator.password:
              if (value!.trim().isEmpty) {
                return locale.get("Please enter your password");
              } else if (value.length < 8) {
                return locale.get("Password should be at least 8 characters");
              } else if (value.length > 32) {
                return locale.get("Password should be at most 32 characters");
              }
              return null;

            ///============================================================================= [ MinLength ]
            case Validator.minLength:
              if (value!.trim().isEmpty) {
                return locale.get("Required");
              } else if (value.length < 8) {
                return locale.get("Minimum length is 8 characters");
              }
              return null;

            ///============================================================================= [ MaxLength ]
            case Validator.maxLength:
              if (value!.trim().isEmpty) {
                return locale.get("Required");
              } else if (value.length > 12) {
                return locale.get("Maximum length is 12 characters");
              }
              return null;

            ///============================================================================= [ IsMatch ]
            case Validator.isMatch:
              if (value!.trim().isEmpty) {
                return locale.get("Required");
              } else if (value != matchedValue) {
                return locale.get("Password not matched");
              }
              return null;
            default:
              return null;
          }
        },
        onTapOutside: onTapOutside ?? (_) => FocusScope.of(context).unfocus(),
        onTap: onTap,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
