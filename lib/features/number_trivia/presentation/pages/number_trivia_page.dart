import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivial/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:number_trivial/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:number_trivial/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Number Trivia")),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              //Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                },
              ),

              SizedBox(
                height: 20,
              ),
              TrivialControls()
            ],
          ),
        ),
      ),
    );
  }
}