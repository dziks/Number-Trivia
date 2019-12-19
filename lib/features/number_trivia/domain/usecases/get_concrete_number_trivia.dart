import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:number_trivial/core/error/failures.dart';
import 'package:number_trivial/core/usecase/usecase.dart';
import 'package:number_trivial/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivial/features/number_trivia/domain/repositories/number_triva_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
