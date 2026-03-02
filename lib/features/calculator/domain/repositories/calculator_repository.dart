import '../entities/calculation.dart';

/// Abstract repository interface for calculator operations.
/// This lives in the domain layer and defines the contract
/// that the data layer must implement.
abstract class CalculatorRepository {
  Calculation calculate({
    required double firstOperand,
    required double secondOperand,
    required String operator,
  });
}
