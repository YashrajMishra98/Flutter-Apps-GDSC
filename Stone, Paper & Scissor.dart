import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(StonePaperScissorsGame());
}

class StonePaperScissorsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text('Stone Paper Scissors'),
          backgroundColor: Colors.blueGrey[700],
        ),
        body: StonePaperScissors(),
      ),
    );
  }
}

class StonePaperScissors extends StatefulWidget {
  @override
  _StonePaperScissorsState createState() => _StonePaperScissorsState();
}

class _StonePaperScissorsState extends State<StonePaperScissors> {
  String userChoice = '';
  String computerChoice = '';
  String result = '';

  final choices = ['Stone', 'Paper', 'Scissors'];

  void playGame(String userChoice) {
    setState(() {
      this.userChoice = userChoice;
      computerChoice = choices[Random().nextInt(3)];
      result = determineWinner(userChoice, computerChoice);
    });
  }

  String determineWinner(String userChoice, String computerChoice) {
    if (userChoice == computerChoice) {
      return "It's a Draw!";
    } else if ((userChoice == 'Stone' && computerChoice == 'Scissors') ||
        (userChoice == 'Scissors' && computerChoice == 'Paper') ||
        (userChoice == 'Paper' && computerChoice == 'Stone')) {
      return "You Win!";
    } else {
      return "You Lose!";
    }
  }

  Widget buildChoiceButton(String choice) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => playGame(choice),
        child: Text(
          choice,
          style: TextStyle(fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.blueGrey[700], // Corrected: backgroundColor
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Your Choice: $userChoice',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(
          'Computer\'s Choice: $computerChoice',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(
          '$result',
          style: TextStyle(
              color: result == "You Win!"
                  ? Colors.green
                  : result == "You Lose!"
                      ? Colors.red
                      : Colors.yellow,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildChoiceButton('Stone'),
            buildChoiceButton('Paper'),
            buildChoiceButton('Scissors'),
          ],
        ),
      ],
    );
  }
}