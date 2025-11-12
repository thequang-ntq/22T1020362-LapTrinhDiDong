import 'package:my_place/widgets/image_detail.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class Share extends StatefulWidget {
  const Share({super.key});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  void _shareContent() {
    SharePlus.instance.share(
      ShareParams(text: 'Check out this awesome place: https://anywhereweroam.com/wp-content/uploads/2023/08/Oeschinensee-Hiking-map-1024x700.webp')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        //Ẩn nút quay lại mặc định ở đầu bên trái
        automaticallyImplyLeading: false,
        title: Text(
          "22T1020362 - Nguyễn Thế Quang",
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.035,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                    horizontal: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
                icon: const Icon(
                  Icons.share, 
                  color: Colors.white,
                ),
                label: Text(
                  "Share this place",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500, 
                    color: Colors.white
                  ),
                ),
                onPressed: _shareContent,
              ),
            ),
          ],
        ),
      )
    );
  }
}