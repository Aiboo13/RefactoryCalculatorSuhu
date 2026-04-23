import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> suhuUnits = ['Celsius', 'Fahrenheit', 'Kelvin', 'Reamur'];

abstract class SuhuEvent {}

class SuhuInputChanged extends SuhuEvent {
  SuhuInputChanged(this.input);

  final String input;
}

class SuhuFromUnitChanged extends SuhuEvent {
  SuhuFromUnitChanged(this.unit);

  final String unit;
}

class SuhuToUnitChanged extends SuhuEvent {
  SuhuToUnitChanged(this.unit);

  final String unit;
}

class SuhuCalculatePressed extends SuhuEvent {}

class SuhuState {
  const SuhuState({
    required this.input,
    required this.fromUnit,
    required this.toUnit,
    required this.result,
  });

  final String input;
  final String fromUnit;
  final String toUnit;
  final double result;

  factory SuhuState.initial() {
    return const SuhuState(
      input: '',
      fromUnit: 'Celsius',
      toUnit: 'Fahrenheit',
      result: 0,
    );
  }

  SuhuState copyWith({
    String? input,
    String? fromUnit,
    String? toUnit,
    double? result,
  }) {
    return SuhuState(
      input: input ?? this.input,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      result: result ?? this.result,
    );
  }
}

class SuhuBloc extends Bloc<SuhuEvent, SuhuState> {
  SuhuBloc() : super(SuhuState.initial()) {
    on<SuhuInputChanged>((event, emit) {
      emit(state.copyWith(input: event.input));
    });

    on<SuhuFromUnitChanged>((event, emit) {
      emit(state.copyWith(fromUnit: event.unit));
    });

    on<SuhuToUnitChanged>((event, emit) {
      emit(state.copyWith(toUnit: event.unit));
    });

    on<SuhuCalculatePressed>((event, emit) {
      final input = double.tryParse(state.input) ?? 0;
      final celsius = _toCelsius(input, state.fromUnit);
      final result = _fromCelsius(celsius, state.toUnit);

      emit(state.copyWith(result: result));
    });
  }

  double _toCelsius(double value, String unit) {
    switch (unit) {
      case 'Fahrenheit':
        return (value - 32) * 5 / 9;
      case 'Kelvin':
        return value - 273.15;
      case 'Reamur':
        return value * 5 / 4;
      default:
        return value;
    }
  }

  double _fromCelsius(double celsius, String unit) {
    switch (unit) {
      case 'Fahrenheit':
        return (celsius * 9 / 5) + 32;
      case 'Kelvin':
        return celsius + 273.15;
      case 'Reamur':
        return celsius * 4 / 5;
      default:
        return celsius;
    }
  }
}
