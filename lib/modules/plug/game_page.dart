import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/core/theme/app_colors.dart';
import 'package:flutter_firebase_config/modules/plug/game_over.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> tileImages = [];
  Timer? timer;
  int score = 0;
  int timeRemaining = 15;
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    generateTileImages();
    startTimer();
  }

  void generateTileImages() {
    final List<String> images = ['assets/images/football.png', 'assets/images/basketball.png'];
    tileImages = List<String>.generate(25, (index) {
      return images[Random().nextInt(2)];
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          timer.cancel();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GameOver(score: score)));
        }
      });
    });
  }

  void swapImage(int index) {
    setState(() {
      tileImages[index] = (tileImages[index] == 'assets/images/football.png')
          ? 'assets/images/basketball.png'
          : 'assets/images/football.png';
      checkGameOver();
    });
  }

  void checkGameOver() {
    if (tileImages.every((image) => image == tileImages[0])) {
      timeRemaining += 5;
      score += 1;
      opacityLevel = 1.0;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          generateTileImages();
          opacityLevel = 0.0;
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ball Swap Game'),
        iconTheme: IconThemeData(
          color: AppColors.textColor, //change your color here
        ),
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Score: $score',
                      style: TextStyle(fontSize: 24, color: AppColors.textColor),
                    ),
                    Text(
                      'Time Remaining: $timeRemaining',
                      style: TextStyle(fontSize: 24, color: AppColors.textColor),
                    ),
                  ],
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: opacityLevel,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          '+10\nseconds!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 5,
            children: List.generate(tileImages.length, (index) {
              return GestureDetector(
                onTap: () => swapImage(index),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  child: Image.asset(tileImages[index]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
