import 'package:flutter_firebase_config/core/theme/app_colors.dart';
import 'package:flutter_firebase_config/modules/plug/game_page.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final int score;

  GameOver({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Game Over',
            style: TextStyle(
              color: AppColors.gameOverTextColor,
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    color: Colors.black),
                Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: Colors.black),
                Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                    color: Colors.black),
                Shadow(
                    // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: Colors.black),
              ],
            ),
          ),
          const SizedBox(height: 50.0),
          Text('Your Score is: $score',
              style: const TextStyle(color: Colors.white, fontSize: 20.0)),
          const SizedBox(height: 50.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.snakeColor,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => GamePage()));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, color: AppColors.textColor, size: 30.0),
                const SizedBox(width: 10),
                Text(
                  'Try Again',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
