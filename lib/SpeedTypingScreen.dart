import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Import for Syncfusion Gauges
import 'package:google_fonts/google_fonts.dart';

class SpeedTypingScreen extends StatefulWidget {
  @override
  _SpeedTypingScreenState createState() => _SpeedTypingScreenState();
}

class _SpeedTypingScreenState extends State<SpeedTypingScreen> {
  Timer? _timer;
  int _timeLeft = 60;
  double _progress = 1.0;
  String sampleText =
      "Name persistence in the face of adversity defines your strength and character.";
  String typedText = "";
  int wpm = 0, errors = 0, accuracy = 0;
  TextEditingController _controller = TextEditingController();

  // Starts a timer that counts down every second
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

  // Resets the game and the progress
  void _resetGame() {
    setState(() {
      _timeLeft = 60;
      _progress = 1.0;
      _controller.clear();
      wpm = 0;
      errors = 0;
      accuracy = 0;
    });
  }

  // Highlights the typed text and compares it with the sample text
  List<TextSpan> _highlightText(String input) {
    List<TextSpan> spans = [];
    for (int i = 0; i < sampleText.length; i++) {
      Color color = Colors.white;
      if (i < input.length) {
        color = input[i] == sampleText[i] ? Colors.green : Colors.red;
      }
      // Adding background color to the typed characters
      spans.add(TextSpan(
        text: sampleText[i],
        style: TextStyle(
          color: color,
          backgroundColor: i < input.length
              ? Colors.blue.withOpacity(0.3)
              : Colors.transparent,
        ),
      ));
    }
    return spans;
  }

  // Updates the statistics: WPM, accuracy, and errors
  void _updateTyping(String value) {
    setState(() {
      typedText = value.trim(); // Removing extra spaces
      List<String> sampleWords = sampleText
          .toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), '') // Removing special characters
          .split(RegExp(r'\s+'));

      List<String> typedWords = value
          .toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), '') // Removing special characters
          .split(RegExp(r'\s+'));

      int correctWords = 0;
      errors = 0;

      // Checking if each word is correct
      for (int i = 0; i < typedWords.length; i++) {
        if (i < sampleWords.length && typedWords[i] == sampleWords[i]) {
          correctWords++;
        } else {
          errors++;
        }
      }

      // Calculating WPM (Words Per Minute)
      wpm = (_timeLeft < 60 && correctWords > 0)
          ? (correctWords * (60 ~/ (60 - _timeLeft))).clamp(0, 200)
          : 0;

      // Calculating Accuracy
      accuracy = (typedWords.isNotEmpty)
          ? ((correctWords / typedWords.length) * 100).toInt().clamp(0, 100)
          : 0;
    });
  }

  // Formats time as MM:SS
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  // Builds a circular container with gauge for displaying accuracy, WPM, and errors
  Widget buildCircularContainer(String label, double value, String displayValue) {
    Color labelColor;
    if (label == "WPM") {
      labelColor = Colors.cyan; // WPM in cyan
    } else if (label == "Errors") {
      labelColor = Colors.red; // Errors in red
    } else {
      labelColor = Colors.lime; // Accuracy in lime green
    }

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
          ),
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: 100,
                ranges: [
                  GaugeRange(startValue: 0, endValue: 50, color: Colors.red),
                  GaugeRange(startValue: 50, endValue: 80, color: Colors.yellow),
                  GaugeRange(startValue: 80, endValue: 100, color: Colors.green),
                ],
                pointers: [NeedlePointer(value: value)],
                annotations: [
                  GaugeAnnotation(
                    widget: Text(
                      displayValue, // Display the value dynamically
                      style: GoogleFonts.pacifico().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.pacifico().copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: labelColor, // Custom color based on the label
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.7),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.exit_to_app, color: Colors.blue),
        ),
        title: Center(
          child: Text(
            'Speed Typer',
            style: GoogleFonts.pacifico(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.deepPurpleAccent,
              letterSpacing: 2.0,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
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
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.85,
            colors: [
              Colors.deepPurple.shade800,
              Colors.blue.shade600,
            ],
            stops: [0.3, 1],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20), // Space for a little separation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCircularContainer("Accuracy", accuracy.toDouble(), "$accuracy%"),
                  buildCircularContainer("WPM", wpm.toDouble(), "$wpm"),
                  buildCircularContainer("Errors", errors.toDouble(), "$errors"),
                ],
              ),
              SizedBox(height: 20), // Space between gauges and timer
              Text(
                formatTime(_timeLeft),
                style: GoogleFonts.pacifico().copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white.withOpacity(0.3),
                color: Colors.greenAccent,
                minHeight: 8,
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    children: _highlightText(_controller.text),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                onChanged: (text) {
                  if (text.length == 1) _startTimer();
                  _updateTyping(text);
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
}
