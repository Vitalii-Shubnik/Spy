import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  GameCard({Key? key}) : super(key: key);

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text('Game card'),
    );
  }
}