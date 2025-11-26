import 'package:api_example/model/rating.dart';

class Product {
  int id;
  String title;
  dynamic price; //dynamic: kiểu dữ liệu đa dạng, tùy thích
  String description;
  String category;
  String image;
  //Bài tập: Khai báo rating
  Rating rating;
  
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image, //nếu không có required thì không bắt buộc, nhưng phải gán dữ liệu
    required this.rating,
  });

  //Từ JSON sang class object, bên key là String, bên value chưa biết nên dynamic
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Nếu json['id'] null thì lấy 0, còn khác null thì lấy nó
      title: json['title'] ?? '', 
      price: json['price'] ?? 0, 
      description: json['description'] ?? '', 
      category: json['category'] ?? '',
      image: json['image'] ?? '', 
      rating: Rating.fromJson(json['rating'] ?? {}),
    );
  }

  // Method để convert sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }
}