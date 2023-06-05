import 'dart:async';
import 'dart:math';

import 'package:flutter_firebase_config/core/theme/app_colors.dart';
import 'package:flutter_firebase_config/modules/plug/game_over.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late int _playerScore;
  late bool _hasStarted;
  late Animation<double> _snakeAnimation;
  late AnimationController _snakeController;
  Timer? gameTimer;
  late String _currentSnakeDirection;
  late int _snakeFoodPosition;
  List _snake = [404, 405, 406, 407];
  final int _noOfSquares = 480;
  final Duration _duration = Duration(milliseconds: 250);
  final int _squareSize = 20;
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    _setUpGame();
  }

  void _setUpGame() {
    _playerScore = 0;
    _currentSnakeDirection = 'RIGHT';
    _hasStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_noOfSquares);
    } while (_snake.contains(_snakeFoodPosition));
    _snakeController = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _snakeController);
  }

  @override
  void dispose() {
    if (gameTimer != null && gameTimer!.isActive) gameTimer!.cancel();
    super.dispose();
  }

  void _gameStart() {
    gameTimer = Timer.periodic(Duration(milliseconds: 250), (Timer timer) {
      _updateSnake();
      if (_hasStarted) timer.cancel();
    });
  }

  bool _gameOver() {
    for (int i = 0; i < _snake.length - 1; i++)
      if (_snake.last == _snake[i]) return true;
    return false;
  }

  void _updateSnake() {
    if (!_hasStarted) {
      setState(() {
        _playerScore = (_snake.length - 4);
        switch (_currentSnakeDirection) {
          case 'DOWN':
            if (_snake.last > _noOfSquares)
              _snake.add(
                  _snake.last + _squareSize - (_noOfSquares + _squareSize));
            else
              _snake.add(_snake.last + _squareSize);
            break;
          case 'UP':
            if (_snake.last < _squareSize)
              _snake.add(
                  _snake.last - _squareSize + (_noOfSquares + _squareSize));
            else
              _snake.add(_snake.last - _squareSize);
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0)
              _snake.add(_snake.last + 1 - _squareSize);
            else
              _snake.add(_snake.last + 1);
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0)
              _snake.add(_snake.last - 1 + _squareSize);
            else
              _snake.add(_snake.last - 1);
        }

        if (_snake.last != _snakeFoodPosition)
          _snake.removeAt(0);
        else {
          do {
            _snakeFoodPosition = _random.nextInt(_noOfSquares);
          } while (_snake.contains(_snakeFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _hasStarted = !_hasStarted;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GameOver(score: _playerScore)));
        }
      });
    }
  }

  Widget _renderField (int index) {
    if (_snake.contains(index)) {
      return Container(color: AppColors.snakeColor);
    } else if (index == _snakeFoodPosition) {
        return Container(
          color: AppColors.fieldColor,
          child: Image.asset('assets/images/diamond.png'),
        );
    } else {
      return Container(color: AppColors.fieldColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Snake Game',
          style: TextStyle(color: AppColors.textColor, fontSize: 20.0),
        ),
        iconTheme: IconThemeData(
          color: AppColors.textColor, //change your color here
        ),
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Score: $_playerScore',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.textColor,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.snakeColor,
        elevation: 20,
        label: Text(
          _hasStarted ? 'Start' : 'Pause',
          style: TextStyle(color: AppColors.textColor),
        ),
        onPressed: () {
          setState(() {
            if (_hasStarted)
              _snakeController.forward();
            else
              _snakeController.reverse();
            _hasStarted = !_hasStarted;
            _gameStart();
          });
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _snakeAnimation,
          color: AppColors.textColor,
        ),
      ),
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: (drag) {
            if (drag.delta.dy > 0 && _currentSnakeDirection != 'UP')
              _currentSnakeDirection = 'DOWN';
            else if (drag.delta.dy < 0 && _currentSnakeDirection != 'DOWN')
              _currentSnakeDirection = 'UP';
          },
          onHorizontalDragUpdate: (drag) {
            if (drag.delta.dx > 0 && _currentSnakeDirection != 'LEFT')
              _currentSnakeDirection = 'RIGHT';
            else if (drag.delta.dx < 0 && _currentSnakeDirection != 'RIGHT')
              _currentSnakeDirection = 'LEFT';
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              itemCount: _squareSize + _noOfSquares,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _squareSize),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    color: AppColors.fieldColor,
                    padding: _snake.contains(index)
                        ? EdgeInsets.all(1)
                        : EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius:
                          index == _snakeFoodPosition || index == _snake.last
                              ? BorderRadius.circular(7)
                              : _snake.contains(index)
                                  ? BorderRadius.circular(2.5)
                                  : BorderRadius.circular(1),
                      child: _renderField(index)
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
