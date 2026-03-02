class Calculation {
  final double firstOperand;
  final double secondOperand;
  final String operator;
  final double result;

  const Calculation({
    required this.firstOperand,
    required this.secondOperand,
    required this.operator,
    required this.result,
  });

  @override
  String toString() => '$firstOperand $operator $secondOperand = $result';
}
