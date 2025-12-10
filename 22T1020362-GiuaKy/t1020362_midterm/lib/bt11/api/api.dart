import 'package:t1020362_midterm/bt11/model/product.dart';
import 'package:dio/dio.dart';

class API {
  Future<List<Product>> getAllProduct() async {
    var dio = Dio();
    var url = "https://fakestoreapi.com/products";
    var response = await dio.request(url); // Mặc định là get
    List<Product> ls = [];
    //Thành công -> 200, thất bại -> khác
    if(response.statusCode == 200) {
      //Lấy dữ liệu - dạng JSON
      List data = response.data;
      ls = data.map(
        //tương tự (json) { return Product.formJson(json) }
        (json) => Product.fromJson(json)
      ).toList();
    }
    else {
      String error = response.statusMessage ?? "lỗi gì đó";
      print("Lỗi: " + error);
    }
    return ls;
  }
}

//Biến toàn cục
var testAPI = API();