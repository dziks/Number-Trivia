import 'package:dartz/dartz.dart';
import 'package:number_trivial/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      //storing the passed string to a converted integer
      final integer = int.parse(str);

      //checking if the passed string is a negative and trowing an exception
      if (integer < 0) throw FormatException();

      //if th value is greater than 0 return the integer form
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

//class for the invalid InputFailure
//if the string passed is either negative and a string
class InvalidInputFailure extends Failure {}
