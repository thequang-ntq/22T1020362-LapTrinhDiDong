import 'package:my_place/screens/phone.dart';
import 'package:my_place/screens/route.dart';
import 'package:my_place/screens/share.dart';
import 'package:my_place/widgets/image_detail.dart';
import 'package:flutter/material.dart';

class MyPlace extends StatefulWidget {
  const MyPlace({super.key});

  @override
  State<MyPlace> createState() => _MyPlaceState();
}

class _MyPlaceState extends State<MyPlace> {
  bool isStared = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        title: Text(
          "22T1020362 - Nguyễn Thế Quang",
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.035,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //1
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const ImageDetail(), 
                  ),
                );
              },
              child: Image(
                image: AssetImage('../../assets/images/img.jpg'),
              ),
            ),
            //2
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //2.1
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oeschinen Lake Campground',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        'Kandersteg, Switzerland',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.032,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  //2.2
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isStared = !isStared;
                          });
                        },
                        child: Icon(
                          Icons.star,
                          color: isStared == true ? 
                            const Color.fromARGB(255, 234, 106, 97)
                          : 
                            const Color.fromARGB(255, 255, 255, 255),
                          size: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        isStared == true ?
                          '41'
                        :
                          '40',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 101, 101, 101),
                          fontSize: MediaQuery.of(context).size.width * 0.032,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //3
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //3.1
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const Phone(), 
                          ),
                        );
                      },
                      child: Icon(
                        Icons.phone,
                        color: const Color.fromARGB(255, 57, 158, 241),
                      size: MediaQuery.of(context).size.width * 0.055,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      'CALL',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 57, 158, 241),
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                //3.2
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                          Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const MyRoute(), 
                          ),
                        );
                      },
                      child: Transform.rotate(
                        angle: 0.5,
                        child: Icon(
                          Icons.navigation,
                          color: const Color.fromARGB(255, 57, 158, 241),
                          size: MediaQuery.of(context).size.width * 0.055,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      'ROUTE',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 57, 158, 241),
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                //3.3
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const Share(), 
                          ),
                        );
                      },
                      child: Icon(
                        Icons.share,
                        color: const Color.fromARGB(255, 57, 158, 241),
                      size: MediaQuery.of(context).size.width * 0.055,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      'SHARE',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 57, 158, 241),
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
              ),
              child: Text(
                'Lake Oeschinen lies at the foot of the Blueemlisalp in the Bernese Alps. Situated 1578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warns to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      )
    );
  }
}