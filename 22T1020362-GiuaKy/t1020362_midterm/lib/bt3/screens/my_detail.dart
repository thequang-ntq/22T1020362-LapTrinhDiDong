import 'package:flutter/material.dart';

class MyDetail extends StatelessWidget {
  const MyDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        //Ẩn nút quay lại mặc định ở đầu bên trái
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
          ],
        ),
      )
    );
  }
}