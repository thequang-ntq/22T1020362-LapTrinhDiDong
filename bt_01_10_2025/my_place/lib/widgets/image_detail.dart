import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageDetail extends StatelessWidget {
  const ImageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://commons.wikimedia.org/wiki/File:Oeschinen_Lake,_Kandersteg,_Switzerland_%28Unsplash%29.jpg');

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
            Image(
              image: AssetImage('../../assets/images/img.jpg'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
              ),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'This image is sourced from Wikimedia Commons, specifically the file “Oeschinen Lake, Kandersteg, Switzerland (Unsplash).jpg”. According to the archive information, the photo was taken at Oeschinen Lake (Kandersteg, Switzerland) on August 13, 2016, by Dino Reichmuth, uploaded to Unsplash, and later published on Wikimedia Commons under the CC0 (Public Domain) license. Website link: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: url.toString(),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(255, 57, 158, 241),
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                        height: 1.5,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}