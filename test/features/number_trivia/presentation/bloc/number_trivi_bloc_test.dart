// import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/core/error/failures.dart';
import 'package:number_trivial/core/usecase/usecase.dart';
import 'package:number_trivial/core/util/input_converter.dart';
import 'package:number_trivial/features/number_trivia/domain/entities/number_trivia.dart';

import 'package:number_trivial/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivial/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivial/features/number_trivia/presentation/bloc/bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initial state should be empty', () {
    //arrange

    //act

    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetConcreteNumberTrivia', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test Trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test(
        'should call the inputConverter to Validate and covert it to an unsigned integer',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      //act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is Invalid', () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      //assert
      final expected = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    test('should emit [loading , Loaded ] when data is gotten succesfully ', 
    () async {
      //arrange
      setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ];
    expectLater(bloc.state, emitsInOrder(expected));

    //act
    bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [loading , Error ] when getting data Failed ', 
    () async {
      //arrange
      setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
    expectLater(bloc.state, emitsInOrder(expected));

    //act
    bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [loading , Error ] whith a proper message for the error when the getting data fails ', 
    () async {
      //arrange
      setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
    expectLater(bloc.state, emitsInOrder(expected));

    //act
    bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });
  });


  group('GetRandomNumberTrivia', () {
    
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test Trivia');



   

    test(
      'should get data from the random use case',
      () async {
        // arrange
        
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.dispatch(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test('should emit [loading , Loaded ] when data is gotten succesfully ', 
    () async {
      //arrange
      
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ];
    expectLater(bloc.state, emitsInOrder(expected));

    //act
    bloc.dispatch(GetTriviaForRandomNumber());
    });

    test('should emit [loading , Error ] when getting data Failed ', 
    () async {
      //arrange
      
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
    expectLater(bloc.state, emitsInOrder(expected));

    //act
    bloc.dispatch(GetTriviaForRandomNumber());
    });

    test('should emit [loading , Error ] whith a proper message for the error when the getting data fails ', 
    () async {
      //arrange
     
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
    expectLater(bloc.state, emitsInOrder(expected));

    //act
    bloc.dispatch(GetTriviaForRandomNumber());
    });
  });
}


