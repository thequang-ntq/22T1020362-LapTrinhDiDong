import 'package:t1020362_midterm/bt13/model/user.dart';
import 'package:dio/dio.dart';

class API {
  String accessToken = "";
  final Dio dio = Dio();

  // Đăng nhập và lấy accessToken
  Future<Map<String, dynamic>?> login(String username, String password) async {
    var loginUrl = "https://dummyjson.com/auth/login";

    try {
      var response = await dio.post(
        loginUrl,
        data: {
          "username": username,
          "password": password,
          "expiresInMins": 30,
        },
      );

      if (response.statusCode == 200) {
        accessToken = response.data['accessToken'];
        return response.data;
      } else {
        print("Lỗi: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
      return null;
    }
  }

  // Lấy thông tin chi tiết người dùng
  Future<User?> getUserDetails() async {
    var getUrl = "https://dummyjson.com/auth/me";

    try {
      var response = await dio.get(
        getUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        print("Lỗi: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
      return null;
    }
  }

  // Đăng xuất
  void logout() {
    accessToken = "";
  }
}

var testAPI = API();