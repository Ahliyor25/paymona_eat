import 'package:dart_lesson/ui/utils/colors.dart';
import 'package:dart_lesson/ui/widgets/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AppInputText extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String title;
  final bool? enable;
  AppInputText(
      {Key? key, required this.title, this.controller, this.hint, this.enable})
      : super(key: key);

  @override
  _AppInputTextState createState() => _AppInputTextState();
}

class _AppInputTextState extends State<AppInputText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: widget.title,
          color: black_05,
          size: 15,
          weight: FontWeight.w600,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          enabled: widget.enable,
          controller: widget.controller,
          decoration: InputDecoration(hintText: widget.hint),
        ),
      ],
    );
  }
}
