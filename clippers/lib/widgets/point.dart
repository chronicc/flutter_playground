import 'package:flutter/material.dart';

class Point extends StatelessWidget {
  const Point({
    super.key,
    required this.offset,
    opacity,
    radius,
  })  : opacity = opacity ?? 0.5,
        radius = radius ?? 5.0;

  final Offset offset;
  final double opacity;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: offset.dy - 5,
      left: offset.dx - 5,
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
