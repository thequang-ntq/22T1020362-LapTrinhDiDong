import 'package:my_classroom/widgets/my_component.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  const MyContainer(
    {super.key} 
  );

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {

  // Danh sách môn học (dữ liệu)
  List<Map<String, String>> lst = [
    {
      'title': 'XML và ứng dụng - Nhóm 1',
      'detail': '2025-2026.1.TIN4583.001',
      'students': '58 học viên',
      'img': './../../assets/images/banner.png',
    },
    {
      'title': 'Lập trình ứng dụng cho các thiết bị di động - Nhóm 6',
      'detail': '2025-2026.1.TIN4403.006',
      'students': '55 học viên',
      'img': './../../assets/images/banner2.png',
    },
    {
      'title': 'Lập trình ứng dụng cho các thiết bị di động - Nhóm 5',
      'detail': '2025-2026.1.TIN4403.005',
      'students': '52 học viên',
      'img': './../../assets/images/banner3.png',
    },
    {
      'title': 'Lập trình ứng dụng cho các thiết bị di động - Nhóm 4',
      'detail': '2025-2026.1.TIN4403.004',
      'students': '50 học viên',
      'img': './../../assets/images/banner4.png',
    },
    {
      'title': 'Lập trình ứng dụng cho các thiết bị di động - Nhóm 3',
      'detail': '2025-2026.1.TIN4403.003',
      'students': '52 học viên',
      'img': './../../assets/images/banner5.png',
    },
  ];

  void deleteComponent(int index) {
    setState(() {
      lst.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        leading: IconButton(
          onPressed:() {
            //
          } ,
          icon: Icon(
            Icons.menu,
            color: Color.fromARGB(255, 44, 44, 44),
            size: w * 0.07,
          ),
        ),
        title: Text(
          "Google Lớp học",
          style: TextStyle(
            color: Color.fromARGB(255, 44, 44, 44),
            fontWeight: FontWeight.w600,
            fontSize: w * 0.045,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //
            },
            icon: Image(
              image: AssetImage("./../../assets/images/avatar.png"),
              fit: BoxFit.cover,
            ),
          ),
          IconButton(
            onPressed:() {
              //
            } ,
            icon: Icon(
              Icons.more_horiz,
              color: Color.fromARGB(255, 44, 44, 44),
              size: w * 0.07,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            w * 0.045,
            h * 0.015,
            w * 0.045,
            h * 0.015,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(lst.length, (index) {
              final item = lst[index];
              return Column(
                children: [
                  MyComponent(
                    title: item['title']!,
                    detail: item['detail']!,
                    numberOfStudent: item['students']!,
                    backgroundImage: item['img']!,
                    deleteComponent: () => deleteComponent(index),
                  ),
                  SizedBox(height: h * 0.015),
                ],
              );
            }),
          ),
        ),
      )
    );
  }
}