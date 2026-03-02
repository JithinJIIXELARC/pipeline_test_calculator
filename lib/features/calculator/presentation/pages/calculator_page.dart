import 'package:flutter/material.dart';

import '../bloc/calculator_bloc.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';

/// Main calculator page that assembles the display and button grid.
class CalculatorPage extends StatefulWidget {
  final CalculatorBloc bloc;

  const CalculatorPage({super.key, required this.bloc});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.addListener(_onBlocChanged);
  }

  void _onBlocChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.bloc.removeListener(_onBlocChanged);
    super.dispose();
  }

  // Color palette
  static const _bgColor = Color(0xFF0F0F0F);
  static const _numColor = Color(0xFF2D2D2D);
  static const _opColor = Color(0xFFFF9500);
  static const _funcColor = Color(0xFF505050);
  static const _equalsColor = Color(0xFF4CD964);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              // Display area
              const Spacer(),
              CalculatorDisplay(
                expression: widget.bloc.expression,
                displayText: widget.bloc.displayText,
              ),
              const SizedBox(height: 24),

              // Button grid
              _buildButtonRow([
                _funcBtn('C', onPressed: widget.bloc.clear),
                _funcBtn('±', onPressed: widget.bloc.toggleSign),
                _funcBtn('%', onPressed: widget.bloc.percentage),
                _opBtn('÷'),
              ]),
              _buildButtonRow([
                _numBtn('7'),
                _numBtn('8'),
                _numBtn('9'),
                _opBtn('×'),
              ]),
              _buildButtonRow([
                _numBtn('4'),
                _numBtn('5'),
                _numBtn('6'),
                _opBtn('-'),
              ]),
              _buildButtonRow([
                _numBtn('1'),
                _numBtn('2'),
                _numBtn('3'),
                _opBtn('+'),
              ]),
              _buildButtonRow([
                _numBtn('0', flex: 2),
                _numBtn('.'),
                _equalsBtn(),
              ]),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<Widget> buttons) {
    return Row(children: buttons);
  }

  Widget _numBtn(String text, {int flex = 1}) {
    return CalculatorButton(
      text: text,
      flex: flex,
      backgroundColor: _numColor,
      onPressed: () => widget.bloc.inputNumber(text),
    );
  }

  Widget _opBtn(String text) {
    final isActive = widget.bloc.expression.endsWith(text);
    return CalculatorButton(
      text: text,
      backgroundColor: isActive ? _opColor.withValues(alpha: 0.7) : _opColor,
      textColor: Colors.white,
      onPressed: () => widget.bloc.inputOperator(text),
    );
  }

  Widget _funcBtn(String text, {required VoidCallback onPressed}) {
    return CalculatorButton(
      text: text,
      backgroundColor: _funcColor,
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }

  Widget _equalsBtn() {
    return CalculatorButton(
      text: '=',
      backgroundColor: _equalsColor,
      textColor: Colors.white,
      onPressed: widget.bloc.evaluate,
    );
  }
}
