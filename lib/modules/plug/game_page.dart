import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/core/theme/app_colors.dart';
import 'package:flutter_firebase_config/modules/plug/game_over.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Color> diamondColors = [
    Colors.red,
    Colors.deepPurple,
    Colors.green,
    Colors.amber,
  ];
  String diamondImage = 'assets/images/diamond.svg';
  Color targetColor = Colors.red;
  List<Color?> diamondGrid = [];
  Timer? timer;
  int score = 0;
  int timeRemaining = 15;
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    startGame();
    startTimer();
  }

  void startGame() {
    setState(() {
      targetColor = diamondColors[Random().nextInt(diamondColors.length)];
      diamondGrid = List<Color?>.generate(
          16, (index) => diamondColors[Random().nextInt(diamondColors.length)]);
    });
  }

  void onGameOver() {
    timer?.cancel();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => GameOver(score: score)));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        onGameOver();
      }
    });
  }

  void selectDiamond(int index) {
    if (diamondGrid[index] == targetColor) {
      setState(() {
        diamondGrid[index] = null;
        score++;
      });
      if (!diamondGrid.contains(targetColor)) {
        timeRemaining += 3;
        startGame();
        opacityLevel = 1.0;
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            opacityLevel = 0.0;
          });
        });
      }
    } else {
      onGameOver();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Diamond Game'),
        iconTheme: IconThemeData(
          color: AppColors.textColor, //change your color here
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/background.jpg', fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Find all diamonds:',
                              style: TextStyle(fontSize: 24, color: AppColors.textColor),
                            ),
                            if (targetColor != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SvgPicture.asset(
                                  diamondImage,
                                  height: 40,
                                  width: 40,
                                  color: targetColor,
                                ),
                              ),
                          ],
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
                              '+3\nseconds!',
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
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                padding: EdgeInsets.zero,
                itemCount: diamondGrid.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => selectDiamond(index),
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
        ],
      ),
    );
  }
}
