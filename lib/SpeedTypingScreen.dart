import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';  // Import the lottie package

class SpeedTypingScreen extends StatefulWidget {
  @override
  _SpeedTypingScreenState createState() => _SpeedTypingScreenState();
}

class _SpeedTypingScreenState extends State<SpeedTypingScreen> {
  Timer? _timer;
  int _timeLeft = 60;
  double _progress = 1.0;
  String sampleText = "Your persistence in the face of adversity defines your strength and character.";
  TextEditingController _controller = TextEditingController();
  int wpm = 0, errors = 0, accuracy = 100;

  void _startTimer() {
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
          _progress = _timeLeft / 60;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetGame() {
    setState(() {
      _timeLeft = 60;
      _progress = 1.0;
      _controller.clear();
      wpm = 0;
      errors = 0;
      accuracy = 100;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.7),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Or navigate to a different screen
          },
          icon: Icon(Icons.exit_to_app, color: Colors.blue),
        ),
        title: Center(  // Center the Lottie animation in the AppBar
          child: Lottie.asset(
            'assets/lottie/welcome.json',  // Replace with your animation path
            width: 250,  // Set width for the animation
            height: 400,  // Set height for the animation
          ),
        ),
        actions: [
          IconButton(
            onPressed: _resetGame,
            icon: Icon(Icons.refresh, color: Colors.blue),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade700, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                "${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white.withOpacity(0.3),
                color: Colors.greenAccent,
                minHeight: 8,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatBox("$wpm", "WPM", Colors.blue),
                  _buildStatBox("$accuracy%", "Accuracy", Colors.green),
                  _buildStatBox("$errors", "Errors", Colors.red),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Text(
                  sampleText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller,
                onChanged: (text) {
                  if (text.length == 1) _startTimer();
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintText: "Start typing...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
