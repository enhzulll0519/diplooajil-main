import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Use Material 3 theme
      ),
      home: ResultScreen(),
    );
  }
}

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _selectedLanguage = "English";
  int _selectedTime = 60;
  double _selectedFontSize = 18.0;

  // Toggle for game modes (Easy, Medium, Hard)
  List<bool> _isSelectedGameMode = [true, false, false]; // Default: Easy selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Back sumыг устгах
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16), // Right талын зайг тохируулах
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.black),
              onPressed: _openSettings,
            ),
          ),
        ],
        title: Center(
          child: Lottie.asset(
            'assets/lottie/2.json', // Зурагтай лотти файлын зам
            width: 200, // Өргөн
            height: 400, // Өндөр
          ),
        ),
      ),
      body: Stack(
        children: [
          _background(), // Beautiful gradient background
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Perfect Score! 🎉',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  _glassmorphicCard(),
                  SizedBox(height: 20),
                  _analysisBox(),
                  SizedBox(height: 20),
                  Text(
                    'Next Game Mode',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  _gameModeSelection(),
                  SizedBox(height: 40),
                  _actionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Settings modal for adjusting game settings
  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Transparency effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.85), // Semi-transparent background
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Settings",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent)),
                  Divider(
                      color: Colors.blueAccent,
                      thickness: 1.5), // Stylish divider

                  // Language selection
                  ListTile(
                    title: Text("Language",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      items: ["English", "Mongolian"].map((String lang) {
                        return DropdownMenuItem(value: lang, child: Text(lang));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                    ),
                  ),

                  // Game time selection
                  ListTile(
                    title: Text("Game Time",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    trailing: DropdownButton<int>(
                      value: _selectedTime,
                      items: [60, 180, 300, 600, 1800, 3600].map((int time) {
                        return DropdownMenuItem(
                            value: time,
                            child: Text(
                                "${time ~/ 60} min") // секундийг минутад хөрвүүлж харуулаh
                            );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTime = value!;
                        });
                      },
                    ),
                  ),

                  // Font size selection
                  ListTile(
                    title: Text("Font Size",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    trailing: DropdownButton<double>(
                      value: _selectedFontSize,
                      items: [16.0, 18.0, 20.0, 24.0].map((double size) {
                        return DropdownMenuItem(
                            value: size, child: Text("$size px"));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFontSize = value!;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blueAccent, // Stylish button color
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      shadowColor: Colors.blueAccent
                          .withOpacity(0.4), // Add shadow for depth
                      elevation: 6, // Elevation for button
                    ),
                    child: Text("Save & Close",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Gradient background with glowing effect
  Widget _background() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade900, Colors.indigo.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 30,
          child: _glowCircle(120, Colors.purpleAccent.withOpacity(0.3)),
        ),
        Positioned(
          bottom: 100,
          right: 40,
          child: _glowCircle(150, Colors.blueAccent.withOpacity(0.3)),
        ),
      ],
    );
  }

  // Glowing circle for the background effect
  Widget _glowCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 60,
            spreadRadius: 30,
          ),
        ],
      ),
    );
  }

  // Glassmorphic card for stats
  Widget _glassmorphicCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem('11', 'WPM', Colors.blue),
          _statItem('100%', 'Accuracy', Colors.green),
          _statItem('0', 'Errors', Colors.red),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  // Analysis box showing results of the game
  Widget _analysisBox() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analysis',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Flawless typing! Incredible precision!\nKeep practicing to increase your speed.',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Game mode selection (Easy, Medium, Hard)
  Widget _gameModeSelection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(32),
      ),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(32),
        isSelected: _isSelectedGameMode, // Using the selected game mode
        selectedColor: Colors.white,
        fillColor: Colors.blue,
        color: Colors.black,
        children: [
          _gameModeButton('Easy'),
          _gameModeButton('Medium'),
          _gameModeButton('Hard'),
        ],
        onPressed: (int index) {
          setState(() {
            // Update the selection when a button is pressed
            for (int i = 0; i < _isSelectedGameMode.length; i++) {
              _isSelectedGameMode[i] = i == index;
            }
          });
        },
      ),
    );
  }

  Widget _gameModeButton(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }

  // Action buttons for Play Again and Home
  Widget _actionButtons() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            minimumSize: Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {},
          child: Text('Play Again',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
