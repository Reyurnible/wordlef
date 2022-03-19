import 'package:flutter/material.dart';
import 'package:wordlef/components/play/Keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/play/WordRow.dart';
import 'domain/Letter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordlef',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: PlayPage(title: 'Wordlef'),
    );
  }
}

class PlayPage extends StatefulWidget {
  PlayPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1),
            // Six tiles
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                WordRow(),
                WordRow(),
                WordRow(),
                WordRow(),
                WordRow(),
                WordRow(),
              ],
            ),
            Spacer(flex: 1),
            // Keyboard
            Keyboard(
              onLetterPressed: onLetterKeyPressed,
              onEnterPressed: onEnterKeyPressed,
              onDeletePressed: onDeleteKeyPressed,
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void onLetterKeyPressed(Letter letter) {
    print("Pressed: ${letter.value}");
    Fluttertoast.showToast(
        msg: "Pressed: ${letter.value}",
    );
  }

  void onEnterKeyPressed() {
    print("Pressed: Enter");
    Fluttertoast.showToast(
      msg: "Pressed: Enter",
    );
  }

  void onDeleteKeyPressed() {
    print("Pressed: Delete");
    Fluttertoast.showToast(
      msg: "Pressed: Delete",
    );
  }
}
