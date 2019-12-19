import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:number_trivial/features/number_trivia/domain/entities/number_trivia.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props = const <dynamic>[]]) : super();
}

class Empty extends NumberTriviaState {
  @override
  List<Object> get props => null;
}

//load this state when data is being fetched
class Loading extends NumberTriviaState {
  @override
  List<Object> get props => null;
}

//Load this state when data has been fetched from then remote api
//and being sent to the UI
class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia}) : super([trivia]);

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message}) : super([message]);

  @override
  
  List<Object> get props => [message];
}
