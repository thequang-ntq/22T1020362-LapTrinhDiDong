import 'package:my_classroom/screens/my_detail.dart';
import 'package:flutter/material.dart';

class MyComponent extends StatelessWidget {
  final String title;
  final String detail;
  final String numberOfStudent;
  final String backgroundImage;
  final double scale;
  final Function deleteComponent;
  
  const MyComponent({
    Key? key,
    required this.title,
    required this.detail,
    required this.numberOfStudent,
    required this.backgroundImage,
    this.scale = 1.0,
    required this.deleteComponent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return InkWell(
      onTap:() {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => const MyDetail(), 
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.white.withValues(alpha: 0.2),
      highlightColor: Colors.white.withValues(alpha: 0.5),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.04,
              h * 0.02,
              w * 0.04,
              h * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.047,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: h * 0.004),
                          //detail
                          Text(
                            detail,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.038,
                            ),
                          ),
                        ],
                      ),
                    ), 
                    //IconButton
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(
                                w * 0.045,
                                h * 0.025,
                                w * 0.045,
                                h * 0.04,
                              ),
                              child: SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch, //full ngang
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        deleteComponent();
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Đã hủy đăng ký',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: w * 0.04,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Hủy đăng ký',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: w * 0.04,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: w * 0.07,
                      ),
                    )
    
                  ],
                ),
                SizedBox(height: h * 0.045),
                //numberOfStudent
                Text(
                  numberOfStudent,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.035,
                  ),
                ),
              ],  
            ),
          ),
        ),
      ),
    );
  }
}