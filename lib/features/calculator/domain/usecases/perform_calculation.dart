import '../entities/calculation.dart';
import '../repositories/calculator_repository.dart';

/// Use case that performs a calculation by delegating to the repository.
/// This encapsulates the business logic of the calculator feature.
class PerformCalculation {
  final CalculatorRepository repository;

  const PerformCalculation(this.repository);

  Calculation call({
    required double firstOperand,
    required double secondOperand,
    required String operator,
  }) {
    return repository.calculate(
      firstOperand: firstOperand,
      secondOperand: secondOperand,
      operator: operator,
    );
  }
}
