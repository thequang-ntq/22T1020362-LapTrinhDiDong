import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BMIForm extends StatefulWidget {
  const BMIForm({super.key});

  @override
  State<BMIForm> createState() => _BMIFormState();
}

class _BMIFormState extends State<BMIForm> {
  
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  double? bmi;
  String? type;

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _heightController.dispose();
    _weightController.dispose();
  }

  

  double calculateBMI_bmi(String height, String weight) {
    double hei = double.parse(height);
    int wei = int.parse(weight); 
    double w = wei.toDouble();
    double bmi = double.parse((w / (hei * hei)).toStringAsFixed(2));
    return bmi;
  }

  String calculateBMI_type(String height, String weight) {
    double hei = double.parse(height);
    int wei = int.parse(weight); 
    double w = wei.toDouble();
    double bmi = double.parse((w / (hei * hei)).toStringAsFixed(2));
    bmi = (bmi * 100).roundToDouble() / 100;
    if(bmi < 18.5) return "Thiếu cân";
    if(bmi <= 24.9) return "Bình thường";
    if(bmi <= 29.9) return "Thừa cân";
    return "Béo phì";
  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      appBar: AppBar(
        title: 
          Text(
            "Tính chỉ số BMI",
            style: TextStyle(
              fontSize: w * 0.05,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        backgroundColor: const Color.fromARGB(255, 3, 139, 98),
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
                  // TextFormField chiều cao
                  TextFormField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.height,
                        size: w * 0.05,
                        color: const Color.fromARGB(255, 100, 100, 100),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Chiều cao (m)",
                      hintText: '0.00',
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
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      // Cho phép tối đa 2 chữ số thập phân
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if(value == null || value.isEmpty) return "Vui lòng nhập chiều cao";
                      
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Vui lòng nhập chiều cao hợp lệ (Dạng 2 chữ số thập phân)';
                      }
                      if (number < 0) {
                        return 'Chiều cao phải lớn hơn hoặc bằng 0';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: h * 0.05),
                  // TextFormField cân nặng
                  TextFormField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.scale,
                        size: w * 0.05,
                        color: const Color.fromARGB(255, 100, 100, 100),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Cân nặng (kg)",
                      hintText: '0',
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
                      keyboardType: TextInputType.number,
                    inputFormatters: [
                      // Cho phép số nguyên
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if(value == null || value.isEmpty) return "Vui lòng nhập cân nặng";

                      final number = int.tryParse(value);
                      if (number == null) {
                        return 'Vui lòng nhập cân nặng hợp lệ (Dạng số nguyên)';
                      }
                      if (number < 0) {
                        return 'Cân nặng phải lớn hơn hoặc bằng 0';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: h * 0.06),
                  // Nút Tính toán
                  SizedBox(
                    width: w * 0.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 3, 139, 98)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // setState(() {
                        //   bmi = null;
                        //   type = null;
                        // });
                        if(_formKey.currentState!.validate()) {
                          setState(() {
                            bmi = calculateBMI_bmi(_heightController.text, _weightController.text);
                            type = calculateBMI_type(_heightController.text, _weightController.text);
                          });
                        }
                        else if (bmi != null || type != null) {
                          // Chỉ xóa nếu đã có kết quả cũ
                          setState(() {
                            bmi = null;
                            type = null;
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
                              Icons.calculate,
                              size: w * 0.055,
                              color: Colors.white,
                            ),
                            SizedBox(width: w * 0.025),
                            Text(
                              "Tính BMI",
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
                  SizedBox(height: h * 0.04),
                  Text(
                    bmi == null || bmi! < 0 ? "" : "Chỉ số BMI: " + bmi.toString(),
                    style: TextStyle(
                      fontSize: w * 0.055,
                      color: Colors.red,
                      fontWeight: FontWeight.w700,  
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  Text(
                    type == null || type == "" ? "" : "Phân loại: " + type.toString(),
                    style: TextStyle(
                      fontSize: w * 0.045,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,  
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