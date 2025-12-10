import 'package:flutter/material.dart';
import 'package:t1020362_midterm/bt1/my_home_page.dart';
import 'package:t1020362_midterm/bt10/screens/feedback_form.dart';
import 'package:t1020362_midterm/bt11/screens/my_product.dart';
import 'package:t1020362_midterm/bt12/screens/news_list_screen.dart';
import 'package:t1020362_midterm/bt13/screens/login_screen.dart';
import 'package:t1020362_midterm/bt2/screens/my_place.dart';
import 'package:t1020362_midterm/bt3/screens/my_container.dart';
import 'package:t1020362_midterm/bt4/screens/my_container_2.dart';
import 'package:t1020362_midterm/bt5/my_container_3.dart';
import 'package:t1020362_midterm/bt6/my_container_4.dart';
import 'package:t1020362_midterm/bt7/screens/login_form.dart';
import 'package:t1020362_midterm/bt8/screens/register_form.dart';
import 'package:t1020362_midterm/bt9/screens/bmi_form.dart';
import 'package:t1020362_midterm/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '22T1020362 - Các dự án',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // TODO: Thêm routes cho các project ở đây
      routes: {
        '/project1': (context) => MyHomePage(),
        '/project2': (context) => MyPlace(),
        '/project3': (context) => MyContainer(),
        '/project4': (context) => MyContainer2(),
        '/project5': (context) => MyContainer3(),
        '/project6': (context) => MyContainer4(),
        '/project7': (context) => LoginForm(),
        '/project8': (context) => RegisterForm(),
        '/project9': (context) => BMIForm(),
        '/project10': (context) => FeedbackForm(),
        '/project11': (context) => MyProduct(),
        '/project12': (context) => NewsListScreen(),
        '/project13': (context) => LoginScreen(),
      },
    );
  }
}