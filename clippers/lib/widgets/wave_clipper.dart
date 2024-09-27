import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  WaveClipper({
    Key? key,
    required this.p0,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
    required this.p5,
  });

  Offset p0;
  Offset p1;
  Offset p2;
  Offset p3;
  Offset p4;
  Offset p5;

  @override
  Path getClip(Size size) {
    var path = Path();

    // Position the path starting point at the bottom left corner of the widget
    path.lineTo(p0.dx, p0.dy);

    // Define the control points for the first Bezier curve
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    // Define the control points for the second Bezier curve
    path.quadraticBezierTo(p3.dx, p3.dy, p4.dx, p4.dy);

    // Position the path ending point at the top right corner of the widget
    path.lineTo(p5.dx, p5.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
