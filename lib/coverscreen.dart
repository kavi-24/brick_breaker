import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  const CoverScreen({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return !hasGameStarted
        ? Container(
            alignment: const Alignment(0, -0.1),
            child: Text(
              "Tap to play",
              style: TextStyle(color: Colors.deepPurple[400]),
            ),
          )
        : Container();
  }
}
