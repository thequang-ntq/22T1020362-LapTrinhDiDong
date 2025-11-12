import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
  final String name;
  const MyHeader({    
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<MyHeader> createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  void _submitSearch(String value) {
    if (value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tìm kiếm: $value'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome text
        Text(
          'Welcome,',
          style: TextStyle(
            color: Colors.black,
            fontSize: w * 0.1,
            fontWeight: FontWeight.w800,
            fontFamily: 'SFPro',
            height: 1.2,
          ),
        ),
        Text(
          widget.name,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 1),
            fontSize: w * 0.1,
            fontWeight: FontWeight.w500,
            fontFamily: 'SFPro',
            height: 1.2,
          ),
        ),
        SizedBox(height: h * 0.02),
        // Search bar
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: TextField(
            onSubmitted: _submitSearch,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: w * 0.04,
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.blue,
                size: w * 0.05,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: w * 0.01,
                vertical: h * 0.01,
              ),
            ),
          ),
        ),
        SizedBox(height: h * 0.07),
        Text(
          "Saved Places",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFPro',
            fontSize: w * 0.045,
          ),
        ),
        
      ],
    );
  }
}