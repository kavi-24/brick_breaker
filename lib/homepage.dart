import 'dart:async';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/coverscreen.dart';
import 'package:brick_breaker/gameoverscreen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction { up, down }

class _HomePageState extends State<HomePage> {
  double ballX = 0;
  double ballY = 0;
  double ballYVelocity = 0.01;
  Direction ballDirection = Direction.down;

  double playerX = -0.2;
  double playerWidth = 0.4;

  bool hasGameStarted = false;
  bool isGameOver = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();

      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (ballDirection == Direction.down) {
        ballY += ballYVelocity;
      } else if (ballDirection == Direction.up) {
        ballY -= ballYVelocity;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerWidth + playerX) {
        // print("hit down");
        ballDirection = Direction.up;
      } else if (ballY <= -0.9) {
        // print("hit up");
        ballDirection = Direction.down;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          if (details.delta.dx > 0) {
            playerX += (details.delta.dx) * 0.01;
            if (playerX >= 1) {
              playerX = 1;
            }
            // print("right $details");
            // right swipe
          }
          if (details.delta.dx < 0) {
            playerX += (details.delta.dx) * 0.01;
            if (playerX <= -1) {
              playerX = -1;
            }
            // print("left $details");
            // left swipe
          }
        });
      },
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade100,
        body: Center(
          child: Stack(
            children: [
              CoverScreen(hasGameStarted: hasGameStarted),
              GameOverScreen(isGameOver: isGameOver),
              MyBall(ballX: ballX, ballY: ballY),
              MyPlayer(playerX: playerX, playerWidth: playerWidth),
              /* Container(
                alignment: Alignment(playerX, 0.9),
                child: Container(
                  color: Colors.red,
                  width: 4,
                  height: 15,
                ),
              ),
              Container(
                alignment: Alignment(playerX + playerWidth, 0.9),
                child: Container(
                  color: Colors.green,
                  width: 4,
                  height: 15,
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
