import 'package:flutter/material.dart';

class DetailPlace extends StatelessWidget {
  final String url;
  final String detail;
  const DetailPlace({    
    Key? key,
    required this.url,
    required this.detail,
  }) : super(key: key);

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
          w * 0.05,
          h * 0.03,
          w * 0.05,
          h * 0.03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12), 
              child: Image(
                image: AssetImage(url),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: h * 0.02),
            Text(
              "Chi tiết địa điểm: ${detail}",
              style: TextStyle(
                color: Colors.black,
                fontSize: w * 0.07,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}