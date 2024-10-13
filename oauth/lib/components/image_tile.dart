import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile(
    this.imagePath, {
    super.key,
    required this.onTap,
  });

  final String imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          imagePath,
          width: 32,
        ),
      ),
    );
  }
}
