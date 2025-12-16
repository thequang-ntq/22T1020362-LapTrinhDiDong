class Rating {
  double rate;
  int count;

  Rating({
    required this.rate, 
    required this.count
  });

  // Factory constructor để parse từ JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      // Sửa: Chuyển đổi int thành double nếu cần
      rate: (json['rate'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }

  // Method để convert sang JSON
  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}