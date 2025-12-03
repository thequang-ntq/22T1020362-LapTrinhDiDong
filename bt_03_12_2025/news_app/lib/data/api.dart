import 'package:news_app/model/news.dart';
import 'package:dio/dio.dart';

class API {
  final String apiKey = "614f9a3117fa4c2f9a2d617b582c4471";
  final String baseUrl = "https://newsapi.org/v2";

  Future<List<News>> getAllNews() async {
    var dio = Dio();
    var url = "$baseUrl/everything?q=tesla&from=2025-11-03&sortBy=publishedAt&apiKey=$apiKey";
    
    List<News> ls = [];
    
    try {
      var response = await dio.request(url);
      
      if (response.statusCode == 200) {
        List data = response.data['articles'];
        ls = data.map((json) => News.fromJson(json)).toList();
      } else {
        String error = response.statusMessage ?? "Lỗi không xác định";
        print("Lỗi: $error");
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
    }
    
    return ls;
  }

  Future<List<News>> searchNews(String query) async {
    var dio = Dio();
    var url = "$baseUrl/everything?q=$query&sortBy=publishedAt&apiKey=$apiKey";
    
    List<News> ls = [];
    
    try {
      var response = await dio.request(url);
      
      if (response.statusCode == 200) {
        List data = response.data['articles'];
        ls = data.map((json) => News.fromJson(json)).toList();
      } else {
        String error = response.statusMessage ?? "Lỗi không xác định";
        print("Lỗi: $error");
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
    }
    
    return ls;
  }
}

var testAPI = API();