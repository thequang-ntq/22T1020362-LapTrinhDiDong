import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'BT1 - Bài mở đầu', 
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Lọ đế trở về", 
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                backgroundColor: Color.fromARGB(255, 43, 255, 61),
             )
            ),
          ),
          Icon(
            Icons.heart_broken, 
            color: Colors.red,
            size: MediaQuery.of(context).size.width * 0.1,
          ),
          Text(
            "Lập trình DĐ - Nhóm 2",
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              backgroundColor: Color.fromARGB(255, 239, 255, 18),
            ),
          ),
        ],
      )
    );
  }
}