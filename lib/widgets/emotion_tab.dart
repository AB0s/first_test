import 'package:flutter/material.dart';

class EmotionTab extends StatelessWidget {
  final String assetPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Size size;

  const EmotionTab({
    required this.assetPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.18,
        width: size.width * 0.25,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? Border.all(color: Color(0xFFFF8702), width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, height: size.height * 0.06),
            SizedBox(height: size.height * 0.01),
            Text(
              label,
              style: TextStyle(color: Colors.black, fontSize: size.width * 0.035),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
