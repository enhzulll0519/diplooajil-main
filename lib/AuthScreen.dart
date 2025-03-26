import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:diplooajil/ButtonScreen.dart';

void main() {
  runApp(const TypingMasterApp());
}

class TypingMasterApp extends StatelessWidget {
  const TypingMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleScreen() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void handleAuthAction() {
    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ButtonScreen()),
      );
    } else {
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(top: 0, left: 0, child: Image.asset('assets/images/main_top.png', width: 150)),
          Positioned(bottom: 0, left: 0, child: Image.asset('assets/images/main_top.png', width: 150)),
          Positioned(bottom: 0, right: 0, child: Image.asset('assets/images/login_bottom.png', width: 150)),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Lottie.asset(
                      isLogin ? 'assets/lottie/login.json' : 'assets/lottie/speed.json',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Your email",
                      filled: true,
                      fillColor: Colors.purple.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Your password",
                      filled: true,
                      fillColor: Colors.purple.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: handleAuthAction,
                      child: Text(
                        isLogin ? 'LOGIN' : 'SIGN UP',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isLogin ? "Don't have an account? " : "Already have an account? "),
                      GestureDetector(
                        onTap: toggleScreen,
                        child: Text(
                          isLogin ? "Sign Up" : "Sign In",
                          style: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
