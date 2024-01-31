import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../model/barnyard_defenders_game.dart';

// Olly implemented - chris implemented the ui of overlay to exit game
// olly implemented overlay functionality
// This runs the game

class GamePage extends StatelessWidget {
  //const GamePage({Key? key});
  BarnyardDefendersGame game;
  GamePage({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barnyard Defenders"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app), // You can change the icon as needed
            onPressed: () {
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GameWidget(game: game),
          // Wave Start button
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                game.pauseEngine();
                // go to cards page
                // Chris implemented these upgrades
                Navigator.pushNamed(context, '/roundUpgrade');
                //Navigator.pop(context);
              },
              child: Text("Exit"),
            ),
          ),
        ],
      ),
    );
  }
}

// Chris code that does not work with what i implemented
// class GamePage extends StatefulWidget {
//   const GamePage({Key? key}) : super(key: key);
//
//   @override
//   _GamePageState createState() => _GamePageState();
// }
//
// class _GamePageState extends State<GamePage> {
//   bool isFirstClick = true;
//
//   @override
//   Widget build(BuildContext context) {
//     BarnyardDefendersGame game = BarnyardDefendersGame();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Barnyard Defenders"),
//       ),
//       body: Stack(
//         children: [
//           GameWidget(game: game),
//           if (!isFirstClick)
//             Positioned(
//               top: 100,
//               left: 1,
//               child: Container(
//                 width: 30,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           // Wave Start button
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: ElevatedButton(
//               onPressed: () {
//                 //game.startWave();
//                 if (isFirstClick) {
//                   setState(() {
//                     isFirstClick = false;
//                   });
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         backgroundColor: Colors.black,
//                         content: Text(
//                           "The Game has Started",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24.0,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//               child: Text("Wave Start"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//}

