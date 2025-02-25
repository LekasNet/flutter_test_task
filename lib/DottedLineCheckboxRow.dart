import 'package:flutter/material.dart';

class DottedLineCheckboxRow extends StatefulWidget {
  final String text;
  final bool initialChecked;

  const DottedLineCheckboxRow({
    Key? key,
    required this.text,
    required this.initialChecked,
  }) : super(key: key);

  @override
  _DottedLineCheckboxRowState createState() => _DottedLineCheckboxRowState();
}

class _DottedLineCheckboxRowState extends State<DottedLineCheckboxRow> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialChecked;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double checkboxWidth = 40; // Ширина чекбокса
        double spacing = 16; // Расстояние между элементами
        double minDottedWidth = 10; // Минимальная ширина пунктира
        double maxDottedWidth = totalWidth * 0.5; // Максимальная ширина пунктира

        // Замеряем реальную ширину текста
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: const TextStyle(fontSize: 14),
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout();

        double textWidth = textPainter.width + 40;
        double availableWidth = totalWidth - checkboxWidth - spacing;

        // Определяем ширину пунктира
        double dottedWidth = (availableWidth - textWidth).clamp(minDottedWidth, maxDottedWidth);
        double finalTextWidth = availableWidth - dottedWidth;

        return Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: finalTextWidth),
              child: Text(
                widget.text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: isChecked ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (dottedWidth > minDottedWidth)
              SizedBox(
                width: dottedWidth,
                child: CustomPaint(
                  size: Size(dottedWidth, 1),
                  painter: DottedLinePainter(),
                ),
              ),
            const SizedBox(width: 8),
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
            ),
          ],
        );
      },
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4;
    const double dashSpace = 4;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
