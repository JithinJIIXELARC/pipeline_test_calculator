import 'package:flutter_test/flutter_test.dart';

import 'package:pipeline_test/features/calculator/data/repositories/calculator_repository_impl.dart';
import 'package:pipeline_test/features/calculator/domain/usecases/perform_calculation.dart';

void main() {
  late CalculatorRepositoryImpl repository;
  late PerformCalculation performCalculation;

  setUp(() {
    repository = CalculatorRepositoryImpl();
    performCalculation = PerformCalculation(repository);
  });

  group('CalculatorRepositoryImpl', () {
    test('should add two numbers', () {
      final result = repository.calculate(
        firstOperand: 10,
        secondOperand: 5,
        operator: '+',
      );
      expect(result.result, 15.0);
    });

    test('should subtract two numbers', () {
      final result = repository.calculate(
        firstOperand: 10,
        secondOperand: 3,
        operator: '-',
      );
      expect(result.result, 7.0);
    });

    test('should multiply two numbers', () {
      final result = repository.calculate(
        firstOperand: 4,
        secondOperand: 6,
        operator: '×',
      );
      expect(result.result, 24.0);
    });

    test('should divide two numbers', () {
      final result = repository.calculate(
        firstOperand: 20,
        secondOperand: 4,
        operator: '÷',
      );
      expect(result.result, 5.0);
    });

    test('should throw on division by zero', () {
      expect(
        () => repository.calculate(
          firstOperand: 5,
          secondOperand: 0,
          operator: '÷',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw on unknown operator', () {
      expect(
        () => repository.calculate(
          firstOperand: 5,
          secondOperand: 3,
          operator: '^',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('PerformCalculation use case', () {
    test('should delegate to repository and return calculation', () {
      final result = performCalculation(
        firstOperand: 12,
        secondOperand: 8,
        operator: '+',
      );
      expect(result.result, 20.0);
      expect(result.firstOperand, 12.0);
      expect(result.secondOperand, 8.0);
      expect(result.operator, '+');
    });

    test('should handle negative results', () {
      final result = performCalculation(
        firstOperand: 3,
        secondOperand: 10,
        operator: '-',
      );
      expect(result.result, -7.0);
    });

    test('should handle decimal results', () {
      final result = performCalculation(
        firstOperand: 7,
        secondOperand: 2,
        operator: '÷',
      );
      expect(result.result, 3.5);
    });
  });
}
