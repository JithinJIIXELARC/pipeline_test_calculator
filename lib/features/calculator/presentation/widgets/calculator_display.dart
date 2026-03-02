import 'package:flutter/material.dart';

/// Display widget showing the expression and current input/result.
class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String displayText;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Expression (history) text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              expression,
              key: ValueKey(expression),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white.withValues(alpha: 0.5),
                fontWeight: FontWeight.w300,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          // Main display text
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              displayText,
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
