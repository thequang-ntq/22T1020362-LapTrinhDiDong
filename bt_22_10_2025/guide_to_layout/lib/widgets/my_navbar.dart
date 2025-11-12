import 'package:flutter/material.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({super.key});

  @override
  State<MyNavbar> createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {

  void _tapNofitication(double w) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã nhấn nút thông báo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: w * 0.04,
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

    void _tapExtension(double w) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã nhấn nút tiện ích',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: w * 0.04,
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            _tapNofitication(w);
          },
          icon: Icon(
            Icons.notifications,
            color: const Color.fromARGB(255, 28, 28, 28),
            size: w * 0.06,
          ),
        ),
        IconButton(
          onPressed: () {
            _tapExtension(w);
          },
          icon: Icon(
            Icons.extension,
            color: const Color.fromARGB(255, 28, 28, 28),
            size: w * 0.06,
          ),
        ),
      ],
    );
  }
}