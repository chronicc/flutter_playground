import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timeline/models/timeline_event.dart';
import 'package:timeline/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timeline Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(
        events: List.generate(16, (index) {
          return TimelineEvent(
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            title: 'Event $index',
            time: DateTime.now().add(-Duration(days: index * 800)),
            topics: List.generate(3, (index) {
              return [
                'alpha',
                'beta',
                'gamma',
                'delta',
                'epsilon',
                'sigma'
              ][Random().nextInt(6)];
            }).toSet(),
          );
        }),
      ),
    );
  }
}
