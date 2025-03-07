import 'package:boombox/boombox_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BoomboxApp());
}

class BoomboxApp extends StatelessWidget {
  const BoomboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BoomboxScreen(),
    );
  }
}
