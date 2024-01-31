import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/store_section.dart';
import '../model/attack.dart';
import '../model/upgrade.dart';
import '../model/barnyard_defenders_game.dart';
import 'package:final_barnyard_defenders/actors/defender.dart';

// Here can choose 3 characters to use in game
// Olly implemented this

// Takes title, a game which defenders get added to, and font
class StorePage extends StatefulWidget {
  StorePage({Key? key, required this.title, required this.game, required this.font}) : super(key: key);

  final String title;
  BarnyardDefendersGame game;
  String font;

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // Creating defenders
  Defender shroom = Defender(
      storeImage: Image.asset("assets/images/StoreImages/store_shroom.png", fit: BoxFit.contain),
      idleGameImage: "DefenderAnimations/shroom_idle_(32x32).png",
      title: "Shroom",
      health: 5,
      attack: Attack(damage: 5, rechargeTime: 5, distance: 5),
      animationFrames: 14,
      idleTextureSizeWidth: 32,
      idleTextureSizeHeight: 32
  );
  Defender snail = Defender(
      storeImage: Image.asset("assets/images/StoreImages/store_snail.png", fit: BoxFit.contain),
      idleGameImage: "DefenderAnimations/snail_idle_(38x24).png",
      title: "Snail",
      health: 5,
      attack: Attack(damage: 5, rechargeTime: 5, distance: 5),
      animationFrames: 15,
      idleTextureSizeWidth: 38,
      idleTextureSizeHeight: 24
  );
  Defender chicken = Defender(
      storeImage: Image.asset("assets/images/StoreImages/storechicken.png", fit: BoxFit.contain),
      idleGameImage: "DefenderAnimations/chicken_idle_(32x34).png",
      title: "Chicken",
      health: 5,
      attack: Attack(damage: 5, rechargeTime: 5, distance: 5),
      animationFrames: 13,
      idleTextureSizeWidth: 32,
      idleTextureSizeHeight: 34
  );
  Defender farmer = Defender(
      storeImage: Image.asset("assets/images/StoreImages/store_farmer.png", fit: BoxFit.contain),
      idleGameImage: "DefenderAnimations/farmer_idle_(32x32).png",
      title: "Farmer",
      health: 5,
      attack: Attack(damage: 5, rechargeTime: 5, distance: 5),
      animationFrames: 11,
      idleTextureSizeWidth: 32,
      idleTextureSizeHeight: 32
  );
  Defender raddish = Defender(
      storeImage: Image.asset("assets/images/StoreImages/store_raddish.png", fit: BoxFit.contain),
      idleGameImage: "DefenderAnimations/raddish_idle_(30x38).png",
      title: "Raddish",
      health: 5,
      attack: Attack(damage: 5, rechargeTime: 5, distance: 5),
      animationFrames: 6,
      idleTextureSizeWidth: 30,
      idleTextureSizeHeight: 38
  );

  List<Upgrade>? upgrades;
  List<StoreSection>? _sections;
  List<Defender>? defenders;
  StoreSection? defenderSection;
  StoreSection? upgradeSection;
  List<Defender> _selectedDefenders = [];
  bool _enoughDefenders = false;
  bool _upgradeChosen = false;

  @override
  Widget build(BuildContext context) {
    String _font = widget.font;
    defenders = [shroom, snail, chicken, farmer, raddish];
    // Create upgrades to apply to defenders
    Upgrade shroomHealthUpgrade = Upgrade(title: Text("Shroom Health +5", style: TextStyle(fontFamily: _font),), value: 5,
                                          defender: shroom, upgradeElement: 0);
    Upgrade shroomDamageUpgrade = Upgrade(title: Text("Shroom +5 Damage", style: TextStyle(fontFamily: _font)), value: 3,
                                       defender: shroom, upgradeElement: 1);
    Upgrade snailRechargeUpgrade = Upgrade(title: Text("Snail -5s recharge speed", style: TextStyle(fontFamily: _font)), value: -5,
                                           defender: snail, upgradeElement: 2);
    Upgrade chickenDamageUpgrade = Upgrade(title: Text("Chicken damage +10", style: TextStyle(fontFamily: _font)), value: 10,
                                           defender: chicken, upgradeElement: 3);
    Upgrade farmerRangeUpgrade = Upgrade(title: Text("Farmer attack distance +3", style: TextStyle(fontFamily: _font)), value: 3,
                                         defender: farmer, upgradeElement: 4);
    Upgrade raddishRechargeUpgrade = Upgrade(title: Text("Cannon -5s recharge speed", style: TextStyle(fontFamily: _font)), value: -5,
                                            defender: raddish, upgradeElement: 5);

    upgrades = [shroomHealthUpgrade, shroomDamageUpgrade, snailRechargeUpgrade, chickenDamageUpgrade,
                farmerRangeUpgrade, raddishRechargeUpgrade];

    // Create store sections
    defenderSection = StoreSection(sectionHeader: "Defenders", numberOfSquares: 5,
                                   storeItems: defenders);

    upgradeSection = StoreSection(sectionHeader: "Upgrades", numberOfSquares: 6,
                                  storeItems: upgrades);

    _sections = [defenderSection!, upgradeSection!];

    // Store is a list of 2 seperate grid views the user can tap on to select
    // characters and upgrades
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(widget.title,
            style: TextStyle(fontFamily: _font, fontSize: 30, color: Colors.white)),
      ),
      body: Container(
        color: Colors.red[300],
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(_sections![index].sectionHeader!,
                    style: TextStyle(
                      fontFamily:'Comfortaa',
                        fontSize: 30,
                        color: Colors.white)
                ),
                subtitle: Container(
                    height: 250,
                    // Getting items along with the amount to display
                    child: _storeSectionGrid(_sections![index].numberOfSquares!,
                        _sections![index].storeItems!)
                )
            );
          },
        ),
      ),
    );
  }

  // Grid for the store, each grid has an amount of squares with a defender
  // or upgrade
  Widget _storeSectionGrid(int numberOfSquares, List<Object> storeItems){
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: numberOfSquares,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
              onTap: (){
                // If defender is tapped show dialog with description and
                // ability to select for the game
                // else can apply upgrade and show snackbar
                _selectDefenderOrApplyUpgrade(context, storeItems[index]);
              },
              // To resize image need a stack so I can put another
              // container on top of the grid view that's resizable, and fit an image in that
              child: Stack(
                  children: [
                    Container(
                        color: Colors.white
                    ),
                    Center(
                        child: Container(
                            color: Colors.white,
                            height: 70,
                            width: 80,
                            // Call a function to check type and display accordingly
                            // indexing over list of defender objects or upgrade objects
                            child: _buildItem(storeItems[index])
                        )
                    ),
                  ]
              )
          );
        }
    );
  }

  // When a defender is tapped a dialog pops up, when an upgrade is chosen
  // it gets applied and shown to user via snackbar. If enough defenders are
  // chosen and an upgrade has already been selected, user will see messages saying
  // so.
  Widget? _selectDefenderOrApplyUpgrade(BuildContext context, Object item){
    print("We get here?");
    if (item is Defender && _enoughDefenders == false){
      showDialog(context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text(item.title!, style: TextStyle(fontFamily: widget.font),),
              content: Text(item.description()),
              actions: [
                TextButton(
                    onPressed: (){
                      _selectedDefenders.add(item);
                      print(_selectedDefenders);
                      if (_selectedDefenders.length == 3){
                        widget.game.defenders = _selectedDefenders;
                        print(widget.game.defenders);
                        _enoughDefenders = true;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text("Select")
                )
              ],
            );
          });
    }
    if (item is Defender && _enoughDefenders == true){
      print("enough");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You already chose your defenders!", style: TextStyle(fontFamily: widget.font)),
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

    if (item is Upgrade && _upgradeChosen == false){
      _upgradeChosen = true;
      item.applyUpgrade();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Upgrade applied!", style: TextStyle(fontFamily: widget.font)),
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
    else if (item is Upgrade && _upgradeChosen == true){
      // Add so it shows when can't choose any more upgrades
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You already chose an upgrade!", style: TextStyle(fontFamily: widget.font)),
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
  }

  // If item is a Defender return the image,
  // If its text return text
  Widget? _buildItem(Object item){
    if (item is Defender){
      return item.storeImage!;
    }

    if (item is Upgrade){
      return item.title!;
    }
  }
}

