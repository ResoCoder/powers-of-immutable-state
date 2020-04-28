import 'dart:math';
import 'package:flutter/material.dart';
import 'package:powers_of_immutable_state_presentation/history.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

enum MyState { initial, loading, loaded }

class _MyWidgetState extends State<MyWidget> {
  //! You can also imagine that the fields are inside a ChangeNotifier

  int number; // An asynchronously gotten value is initially "nothing". We can't just assign 0 to it, which is unlike what we did with the counter.
  MyState state = MyState.initial;

  /* Hmm, is ZERO truly the initial history entry?*/
  final history = History<int>(null); //! How to implement history?

  final randomGenerator = Random();

  Future<void> fetchNumber() async {
    setState(() {
      state = MyState.loading;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      number = randomGenerator.nextInt(1000);
      state = MyState.loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Async Number 👎'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //! UNDO Button
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: null,
            ),
            //! Displayed thing
            Builder(
              builder: (context) {
                if (state == MyState.initial) {
                  return Text(
                    'Please, fetch.',
                    // age.toString(),
                    style: TextStyle(fontSize: 40),
                  );
                } else if (state == MyState.loading) {
                  return CircularProgressIndicator();
                } else if (state == MyState.loaded) {
                  return Text(
                    number.toString(),
                    style: TextStyle(fontSize: 80),
                  );
                }
              },
            ),
            //! REDO Button
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          fetchNumber();
        },
      ),
    );
  }
}
