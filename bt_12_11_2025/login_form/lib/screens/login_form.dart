import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool _obscurePassword = false; // Biến để điều khiển ẩn/hiện mật khẩu
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
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
            "Form Đăng nhập",
            style: TextStyle(
              fontSize: w * 0.05,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        backgroundColor: const Color.fromARGB(255, 14, 128, 226),
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
                  // TextFormField Tên người dùng với nền trắng
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
                      labelText: "Tên người dùng",
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
                      if(value == null || value.isEmpty) return "Vui lòng nhập tên người dùng";
                      return null;
                    },
                  ),
                  SizedBox(height: h * 0.045),
                  // TextFormField Mật khẩu với nền trắng và nút mắt
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_obscurePassword, // Ẩn/hiện mật khẩu
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        size: w * 0.05,
                        color: const Color.fromARGB(255, 100, 100, 100),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          size: w * 0.05,
                          color: const Color.fromARGB(255, 100, 100, 100),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Mật khẩu",
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
                      if(value == null || value.isEmpty) return "Vui lòng nhập mật khẩu";
                      if(value.length < 6) return "Mật khẩu phải có ít nhất 6 ký tự";
                      return null;
                    },
                  ),
                  SizedBox(height: h * 0.06),
                  // Nút Đăng nhập
                  SizedBox(
                    width: w * 0.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 12, 117, 204)),
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
                                "Đăng nhập thành công",
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ), 
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h * 0.012),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.login,
                              size: w * 0.055,
                              color: Colors.white,
                            ),
                            SizedBox(width: w * 0.025),
                            Text(
                              "Đăng nhập",
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