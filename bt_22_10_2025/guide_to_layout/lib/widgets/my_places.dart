import 'package:flutter/material.dart';
import 'package:guide_to_layout/widgets/my_place.dart';

class MyPlaces extends StatefulWidget {
  const MyPlaces({super.key});

  @override
  State<MyPlaces> createState() => _MyPlacesState();
}

class _MyPlacesState extends State<MyPlaces> {
  List<Map<String, String>> lst = [
    {
      "url": "./../../assets/images/place1.jpg",
      "detail": "Địa điểm 1",
    },
    {
      "url": "./../../assets/images/place2.jpg",
      "detail": "Địa điểm 2",
    },
    {
      "url": "./../../assets/images/place3.jpg",
      "detail": "Địa điểm 3",
    },
    {
      "url": "./../../assets/images/place4.jpg",
      "detail": "Địa điểm 4",
    },
    {
      "url": "./../../assets/images/place1.jpg",
      "detail": "Địa điểm 1",
    },
    {
      "url": "./../../assets/images/place2.jpg",
      "detail": "Địa điểm 2",
    },
    {
      "url": "./../../assets/images/place3.jpg",
      "detail": "Địa điểm 3",
    },
    {
      "url": "./../../assets/images/place4.jpg",
      "detail": "Địa điểm 4",
    },
        {
      "url": "./../../assets/images/place1.jpg",
      "detail": "Địa điểm 1",
    },
    {
      "url": "./../../assets/images/place2.jpg",
      "detail": "Địa điểm 2",
    },
    {
      "url": "./../../assets/images/place3.jpg",
      "detail": "Địa điểm 3",
    },
    {
      "url": "./../../assets/images/place4.jpg",
      "detail": "Địa điểm 4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid view with 2 columns
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 11,
            mainAxisSpacing: 11,
            childAspectRatio: h * 0.0015,
          ),
          itemCount: lst.length,
          itemBuilder: (context, index) {
            return MyPlace(
              url: lst[index]["url"] ?? "",
              detail: lst[index]["detail"] ?? "",
            );
          },
        ),
      ],
    );
  }
}