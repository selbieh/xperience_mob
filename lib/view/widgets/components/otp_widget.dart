import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class OTPWidget extends StatefulWidget {
  final int codeLength;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final Function(String) callbackFun;
  final TextInputType keyboardType;
  final bool isFilled;
  final Color fillColor;
  final double radius;
  final EdgeInsetsGeometry contentPadding;

  const OTPWidget({
    Key? key,
    required this.codeLength,
    required this.formKey,
    required this.autovalidateMode,
    required this.callbackFun,
    this.isFilled = false,
    this.fillColor = Colors.grey,
    this.radius = 10,
    this.keyboardType = TextInputType.text,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
  }) : super(key: key);

  @override
  OTPWidgetState createState() => OTPWidgetState();
}

class OTPWidgetState extends State<OTPWidget> {
  String otpCode = "";
  List<Widget> fieldList = [];
  List<TextEditingController> controllerList = [];
  List<FocusNode> focusNodeList = [];

  void getOtpCode() {
    otpCode = "";
    for (var element in controllerList) {
      if (element.text.trim().isNotEmpty) {
        otpCode = otpCode + element.text;
      } else {
        return;
      }
    }
    widget.callbackFun(otpCode);
  }

  void buildFields() {
    for (int fieldIndex = 0; fieldIndex < widget.codeLength; fieldIndex++) {
      var codeController = TextEditingController();
      var focusNode = FocusNode();
      controllerList.add(codeController);
      focusNodeList.add(focusNode);
      fieldList.add(
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: controllerList[fieldIndex],
              focusNode: focusNodeList[fieldIndex],
              maxLength: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: widget.keyboardType,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                counterText: '',
                // filled: widget.isFilled,
                // fillColor: widget.fillColor,
                contentPadding: widget.contentPadding,
                errorStyle: const TextStyle(fontSize: 10),
                border: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.grey, width: 1)),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.grey, width: 1)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.grey, width: 1)),
                errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Rquired';
                }
                return null;
              },
              onChanged: (value) {
                controllerList[fieldIndex].text = "";
                controllerList[fieldIndex].clear();
                controllerList[fieldIndex].text = value;
                controllerList[fieldIndex].selection = TextSelection.fromPosition(const TextPosition(offset: 0));
                if (value.isEmpty) {
                  if (fieldIndex > 0) {
                    /// When remove text go to the Previous  TextField
                    FocusScope.of(context).requestFocus(focusNodeList[fieldIndex - 1]);

                    /// When remove text move TextField Cursor to Position 1 (start)
                    if (controllerList[fieldIndex - 1].text.isNotEmpty) {
                      controllerList[fieldIndex - 1].selection = TextSelection.fromPosition(const TextPosition(offset: 1));
                    }
                  }
                } else {
                  if (value.length > 1) {
                    controllerList[fieldIndex].text = value[1];
                  }
                  if (fieldIndex < widget.codeLength - 1) {
                    /// Go to the next TextField
                    FocusScope.of(context).requestFocus(focusNodeList[fieldIndex + 1]);

                    /// Set cursor position at the start of the value in TextField
                    if (controllerList[fieldIndex + 1].text.isNotEmpty) {
                      controllerList[fieldIndex + 1].selection = TextSelection.fromPosition(const TextPosition(offset: 1));
                    } else {
                      controllerList[fieldIndex + 1].selection = TextSelection.fromPosition(const TextPosition(offset: 0));
                    }
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                }
                getOtpCode();
              },
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    buildFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: fieldList,
      ),
    );
  }
}
