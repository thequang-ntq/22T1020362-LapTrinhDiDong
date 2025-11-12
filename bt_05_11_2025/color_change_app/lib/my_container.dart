import 'package:flutter/material.dart';
import 'dart:math';

class MyContainer extends StatefulWidget {
  const MyContainer(
    {super.key} 
  );

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {

  late Color currentColor;
  late String currentColorText;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    currentColor = Colors.purple;
    currentColorText = "RGB(156, 39, 176)";
  }

  void changeColor() {
    setState(() {
      // Tạo màu ngẫu nhiên
      int r = random.nextInt(256);
      int g = random.nextInt(256);
      int b = random.nextInt(256);
      
      currentColor = Color.fromARGB(255, r, g, b);
      currentColorText = "RGB($r, $g, $b)";
    });
  }

  void refreshColor() {
    setState(() {
      currentColor = Colors.purple;
      currentColorText = "RGB(156, 39, 176)";
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: currentColor,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.gif_box,
              color: Colors.yellow,
              size: w * 0.08,
            ),
            SizedBox(width: w * 0.01),
            Text(
              "Ứng dụng Đổi màu nền",
              style: TextStyle(
                fontSize: w * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 0, 185, 89),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Màu hiện tại",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: w * 0.07,
            ),
          ),
          SizedBox(height: h * 0.03,),
          Text(
            currentColorText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: w * 0.06,           
            ),
          ),
          SizedBox(height: h * 0.08,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 185, 89)),
                ),
                onPressed: changeColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        size: w * 0.055,
                        color: Colors.white,
                      ),
                      SizedBox(width: w * 0.02,),
                      Text(
                        "Đổi màu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),  
              ),
              SizedBox(width: w * 0.05,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 143, 142, 142)),
                ),
                onPressed: refreshColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: w * 0.055,
                        color: Colors.white,
                      ),
                      SizedBox(width: w * 0.02,),
                      Text(
                        "Đặt lại",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),  
              ),
            ],
          ),
        ],
      ),
    );
  }
}