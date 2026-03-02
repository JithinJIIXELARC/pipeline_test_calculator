import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pipeline_test/features/calculator/data/repositories/calculator_repository_impl.dart';
import 'package:pipeline_test/features/calculator/domain/usecases/perform_calculation.dart';
import 'package:pipeline_test/features/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:pipeline_test/features/calculator/presentation/pages/calculator_page.dart';

void main() {
  testWidgets('Calculator UI renders buttons and display', (
    WidgetTester tester,
  ) async {
    final repository = CalculatorRepositoryImpl();
    final useCase = PerformCalculation(repository);
    final bloc = CalculatorBloc(performCalculation: useCase);
    // Use a realistic phone-sized surface
    await tester.binding.setSurfaceSize(const Size(400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(MaterialApp(home: CalculatorPage(bloc: bloc)));
    // Verify display shows 0 initially (also matches the 0 button)
    expect(find.text('0'), findsWidgets);

    // Verify number buttons exist
    for (final n in ['1', '2', '3', '4', '5', '6', '7', '8', '9']) {
      expect(find.text(n), findsOneWidget);
    }

    // Verify operator buttons exist
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('×'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);
    expect(find.text('='), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });
}
