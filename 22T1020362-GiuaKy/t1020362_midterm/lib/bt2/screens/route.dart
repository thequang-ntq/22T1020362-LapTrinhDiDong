import 'package:t1020362_midterm/bt2/widgets/image_detail.dart';
import 'package:t1020362_midterm/bt2/widgets/zoom_image.dart';
import 'package:flutter/material.dart';

class MyRoute extends StatefulWidget {
  const MyRoute({super.key});

  @override
  State<MyRoute> createState() => _MyRouteState();
}

class _MyRouteState extends State<MyRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        //Ẩn nút quay lại mặc định ở đầu bên trái
        automaticallyImplyLeading: false,
        title: Text(
          "BT2 - My Place",
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
                image: AssetImage('../../../assets/images/bt2/img.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
                MediaQuery.of(context).size.width * 0.06,
                MediaQuery.of(context).size.height * 0.042,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Image about address of this place (Google Map):",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ZoomImage(
                            imageUrl: "https://anywhereweroam.com/wp-content/uploads/2023/08/Oeschinensee-Hiking-map-1024x700.webp",
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://anywhereweroam.com/wp-content/uploads/2023/08/Oeschinensee-Hiking-map-1024x700.webp",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              "Unable to load image",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width * 0.035, 
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}