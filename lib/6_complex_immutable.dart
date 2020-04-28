import 'package:flutter/material.dart';
import 'package:powers_of_immutable_state_presentation/6_state.dart';

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

class _MyWidgetState extends State<MyWidget> {
  final asyncNumberNotifier = AsyncNumberValueNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Async Number 👍'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //! UNDO Button
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => asyncNumberNotifier.undo(),
            ),
            //! Displayed thing
            ValueListenableBuilder<AsyncNumberState>(
              valueListenable: asyncNumberNotifier,
              builder: (context, value, child) {
                return value.map(
                  initial: (_) {
                    return Text(
                      'Please, fetch.',
                      // age.toString(),
                      style: TextStyle(fontSize: 40),
                    );
                  },
                  loading: (_) {
                    return CircularProgressIndicator();
                  },
                  loaded: (value) {
                    return Text(
                      value.number.toString(),
                      style: TextStyle(fontSize: 80),
                    );
                  },
                );
              },
            ),
            //! REDO Button
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => asyncNumberNotifier.redo(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          asyncNumberNotifier.fetchNumber();
        },
      ),
    );
  }
}
