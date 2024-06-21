import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';

class TextExpansion extends StatefulWidget {
  const TextExpansion({
    Key? key,
    required this.text,
    this.maxLines = 2,
    this.milliseconds = 300,
    this.textAlign = TextAlign.start,
    this.style,
  }) : super(key: key);

  final String text;
  final int maxLines;
  final int milliseconds;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  TextExpansionState createState() => TextExpansionState();
}

class TextExpansionState extends State<TextExpansion> with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: Duration(milliseconds: widget.milliseconds),
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Text(
              widget.text,
              style: widget.style,
              softWrap: true,
              overflow: TextOverflow.fade,
              // overflow: TextOverflow.ellipsis,
              maxLines: isExpanded ? null : widget.maxLines,
              textAlign: widget.textAlign,
            ),
          ),
        ),
        TextButton.icon(
          icon: Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 18,
          ),
          label: Text(
            isExpanded ? "Read less".tr() : "Read more".tr(),
            style: const TextStyle(fontSize: 12),
          ),
          onPressed: () {
            isExpanded = !isExpanded;
            setState(() {});
          },
        )
      ],
    );
  }
}
