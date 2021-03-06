import 'package:flutter/cupertino.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final double? borderRadius;
  final Color? bgColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  AppButton(
      {Key? key,
      this.text,
      this.fontSize,
      this.textColor,
      this.bgColor,
      this.onTap,
      this.fontWeight,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(borderRadius!)),
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
