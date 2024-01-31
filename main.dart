import 'package:final_barnyard_defenders/model/barnyard_defenders_game.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:final_barnyard_defenders/chris_work/cards.dart';
import 'package:final_barnyard_defenders/chris_work/pathing.dart';
import 'package:final_barnyard_defenders/view/login2.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'view/store_page.dart';
import 'package:final_barnyard_defenders/view/main_menu.dart';
import 'package:final_barnyard_defenders/view/mainsettings.dart';
import 'package:final_barnyard_defenders/view/displaystats.dart';
import 'view/game_page.dart';

// This function runs the whole app
// Olly implemented navigation (except navigation within mohammads login)

// Model has models for view pages, views have ui, actors are characters
// in game, and levels deal with map the game loads in, actors, characters, game
// all use flame sprites + animation + gameloop

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortrait();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Game is created - need to add defenders to it, pass it into store to do that
  BarnyardDefendersGame _game = BarnyardDefendersGame();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final comfortaaFont = FontLoader('Comfortaa');
    comfortaaFont.addFont(rootBundle.load('assets/fonts/Comfortaa-Regular.ttf'));
    return MaterialApp(
      title: 'Flutter Demo',
      // Main menu with routes leading to screens
      home: MainMenu(title: 'Barnyard Defenders', game: _game, font: 'Comfortaa'),
      routes: {
        '/store' : (context) => StorePage(title: 'Store', game: _game, font: 'Comfortaa'),
        '/login' : (context) => LoginPage(),
        '/createAccount': (context) => CreateAccountPage(),
        '/settings': (context) => SettingsPage(),
        '/stats': (context) => StatsScreen(),
        '/game': (context) => GamePage(game: _game),
        '/roundUpgrade': (context) => MyScreen(),
      },
    );
  }
}
