import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/styles/app_colors.dart';

class ConnectionErrorScreen extends StatelessWidget {
  const ConnectionErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Text(
            'A network connection is required to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
