import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final Color outlineColor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? direction;
  final TextOverflow? overflow;
  final bool? softWrap;

  const OutlinedText(this.text, this.outlineColor,
      {super.key,
      this.textAlign,
      this.style,
      this.direction,
      this.overflow,
      this.softWrap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(text,
            textAlign: textAlign,
            style: TextStyle(
                fontSize: style?.fontSize,
                fontWeight: style?.fontWeight,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 0.5
                  ..color = outlineColor),
            textDirection: direction,
            overflow: overflow,
            softWrap: softWrap),
        Text(text,
            textAlign: textAlign,
            style: style,
            textDirection: direction,
            overflow: overflow,
            softWrap: softWrap),
      ],
    );
  }
}
