import 'package:dartz/dartz.dart';
import 'package:number_trivial/core/error/failures.dart';
import 'package:number_trivial/core/usecase/usecase.dart';
import 'package:number_trivial/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivial/features/number_trivia/domain/repositories/number_triva_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia,NoParams>{
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

    @override
    Future <Either<Failure,NumberTrivia>>call(NoParams params) async {
      return await repository.getRandomNumberTrivia();
    }
}

