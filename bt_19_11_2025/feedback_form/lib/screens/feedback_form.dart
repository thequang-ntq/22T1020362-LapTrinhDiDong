import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  
  late TextEditingController _usernameController;
  late TextEditingController _contentController;
  
  // Biến lưu giá trị đánh giá (mặc định 4 sao)
  int _selectedRating = 4;

  final _formKey = GlobalKey<FormState>();

  // Danh sách ảnh
  List<XFile> _images = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final List<XFile>? selected = await _picker.pickMultiImage();

    if (selected != null) {
      setState(() {
        _images.addAll(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      appBar: AppBar(
        title: 
          Text(
            "Gửi phản hồi",
            style: TextStyle(
              fontSize: w * 0.05,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        backgroundColor: const Color.fromARGB(255, 216, 82, 4),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TextFormField Họ tên
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        size: w * 0.05,
                        color: const Color.fromARGB(255, 100, 100, 100),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Họ tên",
                      labelStyle: TextStyle(
                        fontSize: w * 0.042,
                        color: const Color.fromARGB(255, 100, 100, 100),
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 200, 200, 200),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 200, 200, 200),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 14, 128, 226),
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: h * 0.02,
                        horizontal: w * 0.04,
                      ),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) return "Vui lòng nhập họ tên";
                      return null;
                    },
                  ),
                  SizedBox(height: h * 0.045),
                  
                  // DropdownButtonFormField cho đánh giá
                  DropdownButtonFormField<int>(
                    value: _selectedRating,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.star,
                        size: w * 0.05,
                        color: const Color.fromARGB(255, 100, 100, 100),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Đánh giá",
                      labelStyle: TextStyle(
                        fontSize: w * 0.042,
                        color: const Color.fromARGB(255, 100, 100, 100),
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 200, 200, 200),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 200, 200, 200),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 14, 128, 226),
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: h * 0.02,
                        horizontal: w * 0.04,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Text('1 sao', style: TextStyle(fontSize: w * 0.04)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Text('2 sao', style: TextStyle(fontSize: w * 0.04)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            Text('3 sao', style: TextStyle(fontSize: w * 0.04)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Row(
                          children: [
                            Text('4 sao', style: TextStyle(fontSize: w * 0.04)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 5,
                        child: Row(
                          children: [
                            Text('5 sao', style: TextStyle(fontSize: w * 0.04)),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedRating = value!;
                      });
                    },
                  ),
                  
                  SizedBox(height: h * 0.045),
                  
                  // TextFormField nội dung góp ý (TextArea)
                  TextFormField(
                    controller: _contentController,
                    maxLines: 5, // Số dòng hiển thị
                    minLines: 3, // Số dòng tối thiểu
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Icon(
                          Icons.feedback,
                          size: w * 0.05,
                          color: const Color.fromARGB(255, 100, 100, 100),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Nội dung góp ý",
                      alignLabelWithHint: true, // Căn label với hint ở trên
                      labelStyle: TextStyle(
                        fontSize: w * 0.042,
                        color: const Color.fromARGB(255, 100, 100, 100),
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 200, 200, 200),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 200, 200, 200),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 14, 128, 226),
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: h * 0.02,
                        horizontal: w * 0.04,
                      ),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) return "Vui lòng nhập nội dung góp ý";
                      return null;
                    },
                  ),
                  SizedBox(height: h * 0.02),

                  // Nút chọn ảnh
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: pickImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 216, 82, 4),
                        padding: EdgeInsets.symmetric(
                            vertical: h * 0.012, horizontal: w * 0.03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.photo, color: Colors.white),
                      label: Text(
                        "Chọn ảnh",
                        style: TextStyle(
                            fontSize: w * 0.042, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  // Preview ảnh
                  if (_images.isNotEmpty)
                    SizedBox(
                      width: w,
                      height: h * 0.18,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: w * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(_images[index].path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 5,
                                      offset: const Offset(2, 3),
                                    )
                                  ],
                                ),
                              ),

                              // Nút xóa ảnh
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  SizedBox(height: h * 0.06),
                  
                  // Nút gửi phản hồi
                  SizedBox(
                    width: w * 0.6,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 216, 82, 4)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Gửi phản hồi thành công",
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ), 
                            ),
                          );

                          setState(() {
                            _selectedRating = 4;
                            _usernameController.text = "";
                            _contentController.text = "";
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h * 0.012),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.send,
                              size: w * 0.055,
                              color: Colors.white,
                            ),
                            SizedBox(width: w * 0.025),
                            Text(
                              "Gửi phản hồi",
                              style: TextStyle(
                                fontSize: w * 0.055,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,                 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}