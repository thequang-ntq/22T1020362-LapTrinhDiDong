import 'package:guide_to_layout/widgets/my_header.dart';
import 'package:guide_to_layout/widgets/my_navbar.dart';
import 'package:guide_to_layout/widgets/my_places.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  const MyContainer(
    {super.key} 
  );

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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