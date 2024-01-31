import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

// Supposed to get a chance for a random upgrade in between plays of game
// chris implemented

class CardData {
  final String title;
  final String description;

  CardData(this.title, this.description);
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  CardData? selectedCard;
  List<CardData> cardData = [];
  List<CardData> selectedCards = [];

  @override
  void initState() {
    super.initState();
    loadCardData();
  }

  Future<void> loadCardData() async {
    final jsonString = await rootBundle.loadString('assets/card_data.json');
    final jsonData = json.decode(jsonString) as List;

    setState(() {
      cardData = jsonData.map((item) => CardData(item['title'], item['description'])).toList();
    });

    // Randomly select three cards from the list of 10
    final random = Random();
    while (selectedCards.length < 3) {
      final randomIndex = random.nextInt(cardData.length);
      if (!selectedCards.contains(cardData[randomIndex])) {
        selectedCards.add(cardData[randomIndex]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select an Upgrade"),
      ),
      body: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Select an Upgrade",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: selectedCards
                    .map(
                      (card) => CardWidget(
                        data: card,
                        isSelected: selectedCard == card,
                        onTap: () {
                          setState(() {
                            selectedCard = card;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: selectedCard != null
                  ? () {
                      print("Upgrade selected: ${selectedCard!.title}");
                    }
                  : null,
              child: Text("Choose"),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final CardData data;
  final bool isSelected;
  final VoidCallback onTap;

  CardWidget({required this.data, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Set the card background to white
          border: isSelected
              ? Border.all(color: Colors.blue, width: 2.0)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(data.description),
          ],
        ),
      ),
    );
  }
}