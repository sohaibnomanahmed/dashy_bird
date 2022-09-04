import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class ScoreTextBox extends TextBoxComponent {
  ScoreTextBox(String text)
      : super(
            text: text,
            textRenderer: TextRenderer.createDefault(),
            children: [
              
            ],
            boxConfig: TextBoxConfig(timePerChar: 0.05));

  final bgPaint = Paint()..color = Colors.grey.shade900;
  final borderPaint = Paint()
    ..color = const Color(0xFF000000)
    ..style = PaintingStyle.stroke;

  @override
  void render(Canvas c) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    c.drawRRect(rrect, bgPaint);
    //canvas.drawRect(rect.deflate(boxConfig.margin), borderPaint);
    super.render(c);
  }
}
