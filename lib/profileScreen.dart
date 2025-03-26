import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Хэрэглэгчийн мэдээлэл',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.grey[600]),
        ),
      ),
      home: UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Хэрэглэгчийн мэдээлэл
    String userName = "Ж. Бат-Эрдэнэ";
    String userEmail = "bat@erdene.com";
    String profileImageUrl = "https://www.example.com/profile.jpg"; // URL зураг

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Хэрэглэгчийн мэдээлэл',
          style: GoogleFonts.poppins(  // Google Fonts ашиглаж байна
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.redAccent, blurRadius: 10),  // Тень үүсгэнэ
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple, // Үзмэн ягаан өнгө
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Та гарсан байна")));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Профайл зураг
              CircleAvatar(
                radius: 80, // Томхон зургаар харуулна
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              SizedBox(height: 20),
              // Нэр
              Text(
                'Нэр: $userName',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              // И-мэйл
              Text(
                'И-мэйл: $userEmail',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 40),
              // Гарах товч
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Та гарсан байна")));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,  // Purple өнгө
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8, // Илүү тод өнгө
                ),
                child: Text('Гарах'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
