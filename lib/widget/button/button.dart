import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final double? heigh;
  final Key? btnkey;
  final Color? color;
  final Color? coloroutline;
  final TextStyle? textStyle;
  final bool isDisabled;

  const Button(
      {super.key,
      this.label,
      this.onPressed,
      this.heigh,
      this.btnkey,
      this.color,
      this.coloroutline,
      this.textStyle,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.94,
      height: heigh ?? MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              isDisabled ? Colors.grey : color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                  color: coloroutline ?? Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          foregroundColor: WidgetStateProperty.all(textStyle?.color),
        ),
        key: btnkey,
        onPressed: isDisabled ? null : onPressed,
        child: AutoSizeText(
          maxLines: 1,
          label ?? "Done",
          style: TextStyle(fontSize: textStyle?.fontSize, fontWeight: textStyle?.fontWeight),
        ),
      ),
    );
  
  }
}

