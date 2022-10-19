import 'package:flutter/material.dart';

class NeuCircle extends StatelessWidget {
  final child;
  const NeuCircle({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle,
      color: Colors.brown[600],
      boxShadow: [
        BoxShadow(
          color: Colors.brown.shade800,
          offset: const Offset(4.0, 4.0),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: Colors.brown.shade500,
          offset: const Offset(-4.0, -4.0),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        )
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.brown.shade500,
          Colors.brown.shade600,
          Colors.brown.shade700,
          Colors.brown.shade800,
        ],
        stops: const [0.1, 0.3, 0.8, 1],
      ),),
      child: child,
    );
  }
}
