import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  const MyContainer(
    {super.key} 
  );

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {

  late int currentNumber;

  @override
  void initState() {
    super.initState();
    currentNumber = 0;
  }

  void increaseNumber() {
    setState(() {
      currentNumber += 1;
    });
  }

  void decreaseNumber() {
    setState(() {
      currentNumber -= 1;
    });
  }

  void refreshNumber() {
    setState(() {
      currentNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calculate,
              color: Colors.yellow,
              size: w * 0.08,
            ),
            SizedBox(width: w * 0.01),
            Text(
              "Ứng dụng Đếm số",
              style: TextStyle(
                fontSize: w * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 45, 98, 233),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Giá trị hiện tại:",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: w * 0.06,
            ),
          ),
          SizedBox(height: h * 0.03,),
          Text(
            currentNumber.toString(),
            style: TextStyle(
              color: const Color.fromARGB(255, 184, 53, 53),
              fontWeight: FontWeight.w800,
              fontSize: w * 0.15,           
            ),
          ),
          SizedBox(height: h * 0.05,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 226, 66, 66)),
                  ),
                  onPressed: decreaseNumber,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      w * 0,
                      h * 0.01,
                      w * 0,
                      h * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove,
                          size: w * 0.055,
                          color: Colors.white,
                        ),
                        SizedBox(width: w * 0.015,),
                        Text(
                          "Giảm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),  
                ),
                SizedBox(width: w * 0.02,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 111, 111, 111)),
                  ),
                  onPressed: refreshNumber,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      w * 0,
                      h * 0.01,
                      w * 0,
                      h * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh,
                          size: w * 0.055,
                          color: Colors.white,
                        ),
                        SizedBox(width: w * 0.015,),
                        Text(
                          "Đặt lại",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),  
                ),
                SizedBox(width: w * 0.02,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 6, 208, 50)),
                  ),
                  onPressed: increaseNumber,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      w * 0,
                      h * 0.01,
                      w * 0,
                      h * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: w * 0.055,
                          color: Colors.white,
                        ),
                        SizedBox(width: w * 0.015,),
                        Text(
                          "Tăng",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}