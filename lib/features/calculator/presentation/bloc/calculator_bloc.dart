import 'package:flutter/foundation.dart';

import '../../domain/usecases/perform_calculation.dart';

/// State management for the calculator using ChangeNotifier.
/// Manages display text, operands, operator, and calculation state.
class CalculatorBloc extends ChangeNotifier {
  final PerformCalculation performCalculation;

  String _displayText = '0';
  String _expression = '';
  double? _firstOperand;
  String? _operator;
  bool _shouldResetDisplay = false;

  CalculatorBloc({required this.performCalculation});

  String get displayText => _displayText;
  String get expression => _expression;

  /// Handles number button presses (0–9 and decimal point).
  void inputNumber(String number) {
    if (_shouldResetDisplay) {
      _displayText = '';
      _shouldResetDisplay = false;
    }

    // Prevent multiple decimal points
    if (number == '.' && _displayText.contains('.')) return;

    // Prevent leading zeros (except for "0.")
    if (_displayText == '0' && number != '.') {
      _displayText = number;
    } else {
      _displayText += number;
    }

    notifyListeners();
  }

  /// Handles operator button presses (+, −, ×, ÷).
  void inputOperator(String operator) {
    final currentValue = double.tryParse(_displayText);
    if (currentValue == null) return;

    // If there's already a pending operation, evaluate it first
    if (_firstOperand != null && _operator != null && !_shouldResetDisplay) {
      _evaluate();
    }

    _firstOperand = double.tryParse(_displayText) ?? _firstOperand;
    _operator = operator;
    _expression = '${_formatNumber(_firstOperand!)} $operator';
    _shouldResetDisplay = true;

    notifyListeners();
  }

  /// Handles the equals button press.
  void evaluate() {
    _evaluate();
    notifyListeners();
  }

  void _evaluate() {
    if (_firstOperand == null || _operator == null) return;

    final secondOperand = double.tryParse(_displayText);
    if (secondOperand == null) return;

    try {
      final calculation = performCalculation(
        firstOperand: _firstOperand!,
        secondOperand: secondOperand,
        operator: _operator!,
      );

      _expression =
          '${_formatNumber(_firstOperand!)} $_operator ${_formatNumber(secondOperand)}';
      _displayText = _formatNumber(calculation.result);
      _firstOperand = calculation.result;
      _operator = null;
      _shouldResetDisplay = true;
    } catch (e) {
      _displayText = 'Error';
      _expression = '';
      _firstOperand = null;
      _operator = null;
      _shouldResetDisplay = true;
    }
  }

  /// Clears all state.
  void clear() {
    _displayText = '0';
    _expression = '';
    _firstOperand = null;
    _operator = null;
    _shouldResetDisplay = false;
    notifyListeners();
  }

  /// Deletes the last character from the display.
  void delete() {
    if (_displayText.length > 1) {
      _displayText = _displayText.substring(0, _displayText.length - 1);
    } else {
      _displayText = '0';
    }
    notifyListeners();
  }

  /// Toggles the sign of the current number.
  void toggleSign() {
    if (_displayText == '0' || _displayText == 'Error') return;

    if (_displayText.startsWith('-')) {
      _displayText = _displayText.substring(1);
    } else {
      _displayText = '-$_displayText';
    }
    notifyListeners();
  }

  /// Calculates percentage of the current number.
  void percentage() {
    final value = double.tryParse(_displayText);
    if (value == null) return;
    _displayText = _formatNumber(value / 100);
    notifyListeners();
  }

  /// Formats a number by removing trailing ".0" for whole numbers.
  String _formatNumber(double number) {
    if (number == number.truncateToDouble()) {
      return number.toInt().toString();
    }
    // Limit decimal places to 10 to avoid floating point noise
    final formatted = number.toStringAsFixed(10);
    // Trim trailing zeros
    return formatted
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
}
