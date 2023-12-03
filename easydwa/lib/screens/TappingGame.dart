import 'dart:async';
import 'package:flutter/material.dart';

class TappingGame extends StatefulWidget {
  @override
  _TappingGameState createState() => _TappingGameState();
}

class _TappingGameState extends State<TappingGame> {
  int _score = 0;
  int _highScore = 0;
  int _timeLeft = 10;
  bool _gameActive = false;
  late Timer _timer;

  void _startGame() {
    setState(() {
      _gameActive = true;
      _score = 0;
      _timeLeft = 10;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        _timer.cancel();
        setState(() {
          _gameActive = false;
          if (_score > _highScore) {
            _highScore = _score;
          }
        });
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _incrementScore() {
    if (_gameActive) {
      setState(() {
        _score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/res.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Score: $_score', style: TextStyle(fontSize: 19, color:Color.fromARGB(255, 19, 19, 19), fontFamily: 'PressStart2P') ),
              Text('HighScore: $_highScore', style: TextStyle(fontSize: 20,color:Color.fromARGB(255, 68, 67, 67), fontFamily: 'PressStart2P')),
              Text('Timeleft: $_timeLeft', style: TextStyle(fontSize: 18
              ,color:Color.fromARGB(255, 247, 44, 44), fontFamily: 'PressStart2P')),
              SizedBox(height: 50),
              Container(
                width: 150,
                height: 150,
                child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 229, 114, 13),
                  splashColor: Color.fromARGB(255, 241, 226, 13),
                  onPressed: _gameActive ? _incrementScore : null,
                  child: Icon(Icons.power_settings_new, size: 120.0),
                  tooltip: 'Tap me!',
                ),
              ),
              SizedBox(height: 50),
              if (!_gameActive)
                ElevatedButton(
                  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 234, 65, 82)),
  ),
                  onPressed: _startGame,
                  child: Text('Start game', style: TextStyle(fontSize: 20, 
                  fontFamily: 'PressStart2P')),
                ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 234, 65, 82)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}