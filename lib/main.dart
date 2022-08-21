import 'package:flutter/material.dart';
import 'package:flutter_project/screens/game_data_form_Screen.dart';
import 'package:flutter_project/screens/homepage.dart';
import 'package:flutter_project/screens/option_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/waiting_lobby.dart';

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
      home: const OptionScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case OptionScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const OptionScreen(),
            );
          case CreateRoom.routeName:
            return MaterialPageRoute(
              builder: (_) => CreateRoom(
                isJoin: settings.arguments as bool,
              ),
            );
          case WaitingLobby.routeName:
            return MaterialPageRoute(builder: (_) => const WaitingLobby());
          case Homepage.routeName:
            return MaterialPageRoute(builder: (_) => const Homepage());

          default:
        }
        return null;
      },
    );
  }
}
