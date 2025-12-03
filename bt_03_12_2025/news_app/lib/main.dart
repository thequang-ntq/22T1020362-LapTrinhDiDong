import 'package:flutter/material.dart';
import 'package:news_app/screens/news_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '22T1020362-News',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6600),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6600),
          primary: const Color(0xFFFF6600),
        ),
        useMaterial3: true,
      ),
      home: const NewsListScreen(),
    );
  }
}