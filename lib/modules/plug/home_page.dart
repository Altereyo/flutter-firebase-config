import 'package:flutter_firebase_config/core/theme/app_colors.dart';
import 'package:flutter_firebase_config/modules/plug/game_page.dart';
import 'package:flutter/material.dart';

class PlugPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child:
                Image.asset('assets/images/background.jpg', fit: BoxFit.cover),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to\nDiamond Game!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 40.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    shadows: const [
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.accentColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GamePage()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.play_arrow,
                          color: Colors.white, size: 30.0),
                      const SizedBox(width: 10),
                      Text(
                        'Start game',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
