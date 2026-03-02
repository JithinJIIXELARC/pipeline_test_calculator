import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/calculator/data/repositories/calculator_repository_impl.dart';
import 'features/calculator/domain/usecases/perform_calculation.dart';
import 'features/calculator/presentation/bloc/calculator_bloc.dart';
import 'features/calculator/presentation/pages/calculator_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar style for dark background
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // ── Dependency Injection ──────────────────────────────────────
  // Data layer
  final repository = CalculatorRepositoryImpl();
  // Domain layer
  final performCalculation = PerformCalculation(repository);
  // Presentation layer
  final bloc = CalculatorBloc(performCalculation: performCalculation);

  runApp(CalculatorApp(bloc: bloc));
}

class CalculatorApp extends StatelessWidget {
  final CalculatorBloc bloc;

  const CalculatorApp({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        fontFamily: 'SF Pro Display',
      ),
      home: CalculatorPage(bloc: bloc),
    );
  }
}
