import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:techbox/core/constants.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const double borderRadius = 5.0;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(borderRadius));

    final path = Path()..addRRect(rrect);
    final dashPath = Path();
    var distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedAddAddressButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const DashedAddAddressButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: ConstantsColor.colorMain,
        strokeWidth: 1.0,
        dashWidth: 3.0,
        dashSpace: 1.0,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.transparent), // Ẩn viền mặc định
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          backgroundColor: Colors.transparent,
        ),
        child: Container(
          height: 22,
          width: 322,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             Image.asset(
                'assets/image/add.png',
                width: 12,
                height: 12,
                color: ConstantsColor.colorMain,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Thêm địa chỉ mới',
                style: TextStyle(
                  color: ConstantsColor.colorMain,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}