import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  const StrokeText(
      {Key? key, this.size = 18, this.text = 'Hello World', this.textAlign})
      : super(key: key);
  final double size;
  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: textAlign ?? TextAlign.start,
          style: TextStyle(
            fontSize: size,
            // letterSpacing: 5,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = Colors.indigo.shade700,
          ),
        ),
        // The text inside
        Text(
          text,
          textAlign: textAlign ?? TextAlign.start,
          style: TextStyle(
            fontSize: size,
            // letterSpacing: 5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
