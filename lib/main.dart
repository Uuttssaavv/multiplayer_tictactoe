import 'package:flutter/material.dart';
import 'package:flutter_project/screens/create.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tic tac toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateRoom(),
    );
  }
}
