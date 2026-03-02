import '../../domain/entities/calculation.dart';
import '../../domain/repositories/calculator_repository.dart';

/// Concrete implementation of the CalculatorRepository.
/// Contains the actual arithmetic logic.
class CalculatorRepositoryImpl implements CalculatorRepository {
  @override
  Calculation calculate({
    required double firstOperand,
    required double secondOperand,
    required String operator,
  }) {
    late double result;

    switch (operator) {
      case '+':
        result = firstOperand + secondOperand;
        break;
      case '-':
        result = firstOperand - secondOperand;
        break;
      case '×':
        result = firstOperand * secondOperand;
        break;
      case '÷':
        if (secondOperand == 0) {
          throw ArgumentError('Cannot divide by zero');
        }
        result = firstOperand / secondOperand;
        break;
      default:
        throw ArgumentError('Unknown operator: $operator');
    }

    return Calculation(
      firstOperand: firstOperand,
      secondOperand: secondOperand,
      operator: operator,
      result: result,
    );
  }
}
