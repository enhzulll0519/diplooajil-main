import 'package:diplooajil/CourseDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    super.key,
    required RiveAnimationController btnAnimationController,
    required this.press,
  }) : _btnAnimationController = btnAnimationController;

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
        // Navigate to CourseDetailsPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CourseDetailsPage()), // Шинэ хуудас руу шилжих
        );
      },
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              controllers: [_btnAnimationController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.arrow_right),
                  const SizedBox(width: 8),
                  Text(
                    "Start the course",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18, // Increase the font size
                          fontWeight: FontWeight.bold, // Make it bold
                          color: Colors.pink, // Set text color to white
                          letterSpacing: 1.2, // Add some space between letters
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ], // Add shadow for depth
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Page')),
      body: const Center(
        child: Text('Welcome to the Course!'),
      ),
    );
  }
}
