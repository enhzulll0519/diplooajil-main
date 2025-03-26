import 'package:diplooajil/SpeedTypingScreen.dart';
import 'package:diplooajil/StatisticsScreen.dart';
import 'package:diplooajil/TypingScoreScreen.dart';
import 'package:diplooajil/profileScreen.dart';
import 'package:diplooajil/resultScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ButtonScreen extends StatefulWidget {
  @override
  _ButtonScreenState createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  int _selectedIndex = 0;

  // List of pages for different tabs
  final List<Widget> _screens = [
    // Home screen is now replaced by ResultScreen
    Container(), // Empty container as the home screen will show ResultScreen immediately
    SpeedTypingScreen(),
    TypingScoreScreen(),
    StatisticsScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Speed Typer'),
      //   centerTitle: false, // Align title to the left
      // ),
      body: _selectedIndex == 0 ? ResultScreen() : _screens[_selectedIndex], // Show ResultScreen for Home tab
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex, // Set selected index
        onTap: (index) {
          if (index == 0) {
            // If the user taps Home, navigate to ResultScreen directly
            setState(() {
              _selectedIndex = index;
            });
          } else {
            setState(() {
              _selectedIndex = index; // Change tab for other selections
            });
          }
        },
        height: 60, // Set height for navigation bar
        items: <Widget>[
          Icon(Icons.sports_esports, size: 30),
          Icon(Icons.timer, size: 30),
          Icon(Icons.bar_chart, size: 30),
          Icon(Icons.show_chart, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.purple, // Set navigation bar color
        backgroundColor: Colors.white, // Set background color for the bar
        buttonBackgroundColor: Colors.white, // Set the color for selected button
        animationCurve: Curves.easeInOut, // Set animation curve
        animationDuration: Duration(milliseconds: 300), // Set animation duration
      ),
    );
  }
}
