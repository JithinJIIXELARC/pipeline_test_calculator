import 'package:flutter/material.dart';

/// Reusable calculator button with press animation and color variants.
class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF2D2D2D),
    this.textColor = Colors.white,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          shadowColor: Colors.black54,
          child: InkWell(
            onTap: onPressed,
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Container(
              height: 72,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: text.length > 1 ? 22 : 28,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
