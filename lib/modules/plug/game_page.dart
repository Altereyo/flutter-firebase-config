import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Color> diamondColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];
  String diamondImage = 'assets/images/diamond.svg';
  Color targetColor = Colors.red;
  List<Color?> diamondGrid = [];
  int score = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      targetColor = diamondColors[Random().nextInt(diamondColors.length)];
      diamondGrid = List<Color?>.generate(
          16, (index) => diamondColors[Random().nextInt(diamondColors.length)]);
      score = 0;
      gameOver = false;
    });
  }

  void selectDiamond(int index) {
    if (diamondGrid[index] == targetColor) {
      setState(() {
        diamondGrid[index] = null;
        score++;
      });
      if (!diamondGrid.contains(targetColor)) {
        startGame();
      }
    } else {
      setState(() {
        gameOver = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diamond Game'),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text(
                'Find all diamonds:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              if (targetColor != null)
                SvgPicture.asset(
                  diamondImage,
                  height: 60,
                  width: 60,
                  color: targetColor,
                )
              else
                Container(),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: diamondGrid.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (!gameOver) {
                    selectDiamond(index);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: diamondGrid[index] != null
                      ? SvgPicture.asset(
                          diamondImage,
                          height: 10,
                          width: 10,
                          color: diamondGrid[index]!,
                        )
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
