import 'package:guide_to_layout/screens/detail_place.dart';
import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  final String url;
  final String detail;
  const MyPlace({    
    Key? key,
    required this.url,
    required this.detail,
  }) : super(key: key);

  void _tapPlace(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => DetailPlace(url: url, detail: detail), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _tapPlace(context);
      },
      borderRadius: BorderRadius.circular(12), // Bo tròn hiệu ứng ripple
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Bo tròn ảnh
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
    );
  }
}