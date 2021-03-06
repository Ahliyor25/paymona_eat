import 'package:flutter/material.dart';

class AppInputTextInline extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final bool? enable;
   AppInputTextInline({Key? key, this.controller, this.hint, this.enable}) : super(key: key);

  @override
  _AppInputTextInlineState createState() => _AppInputTextInlineState();
}

class _AppInputTextInlineState extends State<AppInputTextInline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        enabled: widget.enable,
        controller: widget.controller,
      ),
    );
  }
}
