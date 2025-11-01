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
  /// Builds a ElevatedButton with a SizedBox widget as its parent.
  ///
  /// The SizedBox widget constrains the ElevatedButton's width to be 94% of the screen's width,
  /// and its height to be 7% of the screen's height if the [heigh] property is not provided.
  ///
  /// The ElevatedButton's style is defined with a [ButtonStyle] widget, which sets the
  /// background color to be grey if the [isDisabled] property is true, and sets the foreground
  /// color to be the color defined in the [textStyle] property.
  ///
  /// The ElevatedButton's child is an [AutoSizeText] widget, which displays the text defined in
  /// the [label] property with the font size and weight defined in the [textStyle] property.
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

