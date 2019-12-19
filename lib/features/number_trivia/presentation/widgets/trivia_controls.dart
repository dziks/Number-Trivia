import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivial/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivial/features/number_trivia/presentation/bloc/number_trivia_event.dart';

class TrivialControls extends StatefulWidget {
  const TrivialControls({
    Key key,
  }) : super(key: key);

  @override
  _TrivialControlsState createState() => _TrivialControlsState();
}

class _TrivialControlsState extends State<TrivialControls> {
  String inputStr;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Please Enter a Text',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: RaisedButton(
              elevation: 10.0,
              child: Text('Search'),
              color: Theme.of(context).accentColor,
              textTheme: ButtonTextTheme.primary,
              onPressed: dispatchConcrete,
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: RaisedButton(
              textTheme: ButtonTextTheme.primary,
              elevation: 10.0,
              child: Text('Get Random Trivia'),
              color: Theme.of(context).accentColor,
              onPressed: dispatchRandom,
            )),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForRandomNumber());
  }
}
