import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hardware Keyboard Event Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KeyEventExample(),
    );
  }
}

class KeyEventExample extends StatefulWidget {
  const KeyEventExample({super.key});

  @override
  _KeyEventExampleState createState() => _KeyEventExampleState();
}

class _KeyEventExampleState extends State<KeyEventExample> {
  String lastKeyPressed = 'None';
  final FocusNode _focusNode = FocusNode();
  TextEditingController a = TextEditingController();
  bool s=true;
  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    Future.delayed(const Duration(microseconds: 3), () {
     setState(() {
       s=!s;
     });
      print("Executed after 3  ");
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      setState(() {
        lastKeyPressed = event.logicalKey.keyId.toString();
      });
      return true; // Return true to indicate the event is handled
    }
    return false; // Return false if not handled
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hardware Key Event Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Last Key Pressed: $lastKeyPressed',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: null,
              autofocus: true,
              controller: TextEditingController(),
              focusNode: _focusNode,
              enabled: s,
            ),
          ],
        ),
      ),
    );
  }
}