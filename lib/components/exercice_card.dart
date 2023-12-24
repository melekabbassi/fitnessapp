import 'package:flutter/material.dart';

class ExerciceCard extends StatelessWidget {
  const ExerciceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 400,
        color: Colors.lightGreenAccent,
      ),
    );
  }
}
