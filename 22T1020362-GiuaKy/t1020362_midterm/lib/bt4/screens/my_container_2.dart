import 'package:t1020362_midterm/bt4/widgets/my_header.dart';
import 'package:t1020362_midterm/bt4/widgets/my_navbar.dart';
import 'package:t1020362_midterm/bt4/widgets/my_places.dart';
import 'package:flutter/material.dart';

class MyContainer2 extends StatefulWidget {
  const MyContainer2(
    {super.key} 
  );

  @override
  State<MyContainer2> createState() => _MyContainer2State();
}

class _MyContainer2State extends State<MyContainer2> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        automaticallyImplyLeading: false,
        title: Text(
          'BT4 - Guide To Layout', 
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          w * 0.08,
          h * 0.02,
          w * 0.08,
          h * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyNavbar(),
            SizedBox(height: h * 0.03),
            MyHeader(name: 'Charlie'),
            SizedBox(height: h * 0.018),
            //Cuộn được
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: h * 0.02),
                  child: MyPlaces(),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}