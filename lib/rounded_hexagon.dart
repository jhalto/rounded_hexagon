import 'dart:math';

import 'package:flutter/material.dart';

class RoundedHexagon extends StatelessWidget {
  final double size;
  final Color color;
  final Widget? child;
  final double radius;
  const RoundedHexagon({
    super.key,
    required this.color,
    required this.size,
    this.radius = 8,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedHexagonClipper(cornerRadius: radius),
      child: Container(
        alignment: Alignment.center,
        height: size,
        width: size,
        color: color,
        child: child,
      ),
    );
  }
}

class RoundedHexagonClipper extends CustomClipper<Path> {
  final double cornerRadius;

  RoundedHexagonClipper({this.cornerRadius = 8});

  @override
  Path getClip(Size size) {
    return buildRoundedHexagon(size, cornerRadius);
  }

  @override
  bool shouldReclip(covariant RoundedHexagonClipper oldClipper) {
    return oldClipper.cornerRadius != cornerRadius;
  }
}

Path buildRoundedHexagon(Size size, double radius) {
  final path = Path();
  final center = Offset(size.width / 2, size.height / 2);
  final r = size.width / 2;

  const sides = 6;
  final angle = (2 * pi) / sides;

  final points = List<Offset>.generate(sides, (i) {
    final x = center.dx + r * cos(angle * i - pi / 2);
    final y = center.dy + r * sin(angle * i - pi / 2);
    return Offset(x, y);
  });

  for (int i = 0; i < sides; i++) {
    final current = points[i];
    final next = points[(i + 1) % sides];
    final prev = points[(i - 1 + sides) % sides];

    final dirToPrev = (current - prev).normalize();
    final dirToNext = (next - current).normalize();

    final start = current - dirToPrev * radius;
    final end = current + dirToNext * radius;

    if (i == 0) {
      path.moveTo(start.dx, start.dy);
    } else {
      path.lineTo(start.dx, start.dy);
    }

    path.quadraticBezierTo(current.dx, current.dy, end.dx, end.dy);
  }

  path.close();
  return path;
}

extension OffsetUtils on Offset {
  Offset normalize() {
    final length = distance;
    return length == 0 ? this : this / length;
  }
}
