import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_barnyard_defenders/model/barnyard_defenders_game.dart';

// Buttons leading user to other pages
// Olly did layout and functionality, chris added animated background

class MainMenu extends StatefulWidget {
  MainMenu({Key? key, required this.title, required this.game, required this.font})
      : super(key: key);

  final String title;
  String font;
  BarnyardDefendersGame game;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with TickerProviderStateMixin {
  late AnimationController _bgColorController;
  late Animation<Color?> _bgColorAnimation;

  double opacityLevel = 0.0;
  double translateY = 50.0;

  @override
  void initState() {
    super.initState();
    _initializeBackgroundAnimation();
    _startBackgroundAnimation();

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 1.0;
        translateY = 0.0;
      });
    });
  }

  void _initializeBackgroundAnimation() {
    _bgColorController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );

    _bgColorAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.red[900], end: Colors.brown),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.brown, end: Colors.red[900]),
          weight: 1,
        ),
      ],
    ).animate(_bgColorController);
  }

  void _startBackgroundAnimation() {
    _bgColorController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    String _font = widget.font;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgColorAnimation,
        builder: (context, child) {
          return Container(
            color: _bgColorAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedOpacity(
                  opacity: opacityLevel,
                  duration: Duration(seconds: 2),
                  child: Transform.translate(
                    offset: Offset(0.0, translateY),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 70, bottom: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontFamily: _font,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacityLevel,
                  duration: Duration(seconds: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: _menuButton("Login", () => _login()),
                      ),
                      // Olly implemented below here
                      _menuButton("Store", () => _getDefenders()),
                      _menuButton("Start Game", () => _game()),
                      _menuButton("Stats", () => _stats()),
                      _menuButton("Settings", () => _settings()),
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 200,
                              width: 350,
                              child: Text("Must choose 3 defenders from the store before starting the game.",
                                style: TextStyle(
                                  fontFamily: _font,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                                maxLines: null,
                                softWrap: true,
                                overflow: TextOverflow.clip
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Functions for other pages - olly implemented
  Future<void> _getDefenders() async {
    Navigator.pushNamed(context, '/store');
  }

  Future<void> _login() async {
    Navigator.pushNamed(context, '/login');
  }

  Future<void> _settings() async {
    Navigator.pushNamed(context, '/settings');
  }

  Future<void> _stats() async {
    Navigator.pushNamed(context, '/stats');
  }

  // Have check here to check if game list of defenders is full first,
  // if its not then have snackbar saying choose defenders first
  Future<void> _game() async{
    // When list is empty show warning
    if (widget.game.defenders == null){
      print(widget.game.defenders);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Must select characters first!", style: TextStyle(fontFamily: widget.font)),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Close',
              onPressed: (){
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          )
      );
    }
    else{
      Navigator.pushNamed(context, '/game');
    }
  }

  // Padding surrounding button which takes a title and path,
  // taking user to that page specified by path
  // Olly implemented
  Padding _menuButton(String title, Future<void> Function() onPressed){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[300],
        ),
        child: Container(
          //padding: EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          height: 50,
          width: 200,
          child: Text(title,
            style: TextStyle(fontFamily: widget.font)
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bgColorController.dispose();
    super.dispose();
  }
}