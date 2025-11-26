import 'package:api_example/api/api.dart';
import 'package:api_example/model/product.dart';
import 'package:flutter/material.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {

  //Chỉ giao diện: Hot reload
  //Nếu có dữ liệu: Restart
  @override
  void initState() {
    super.initState();
    testAPI.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: 
          Text(
            "22T1020362 - Mẫu API",
            style: TextStyle(
              fontSize: w * 0.05,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        backgroundColor: const Color.fromARGB(255, 25, 137, 2),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: testAPI.getAllProduct(), 
        //BuildContext: context, AsyncSnapShot: ảnh chụp dữ liệu bất đồng bộ
        builder: (context, snap) {
          //Tải xong dữ liệu
          if(snap.connectionState == ConnectionState.done) {
            if(snap.hasError) {
              return Center(child: Text('Lỗi: ${snap.error}'));
            }
            if(snap.data == null || snap.data!.isEmpty) {
              return Center(child: Text('Không có sản phẩm'));
            }
            return myGridView(snap.data!); //có "!" ở sau bắt buộc khác null
          }
          //Chưa xong -> Đang tải
          else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  //ls bắt buộc khác null
  Widget myGridView(List<Product> ls) {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cột trên mobile
        childAspectRatio: 0.65, // Tỷ lệ chiều rộng/cao
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: ls.length,
      itemBuilder: (context, index) {
        return myItem(ls[index]);
      },
    );
  }

  //Bài tập về nhà tự thiết kế sao cho đẹp, tham khảo tiki, lazada. Card sản phẩm.
  Widget myItem(Product p) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate đến trang chi tiết sản phẩm
          showProductDetail(p);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh sản phẩm
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12)
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12)
                  ),
                  child: Image.network(
                    p.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image, 
                        size: 50, 
                        color: Colors.grey
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / 
                                loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Thông tin sản phẩm
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tên sản phẩm (giới hạn 2 dòng)
                    Text(
                      p.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: 4),

                    // Rating và số lượng đánh giá
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        SizedBox(width: 2),
                        Text(
                          '${p.rating.rate}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(${p.rating.count})',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),

                    // Giá sản phẩm
                    Row(
                      children: [
                        Text(
                          '\$${p.price}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                        Spacer(),
                        // Icon giỏ hàng nhỏ
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.add_shopping_cart,
                            size: 16,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hiển thị chi tiết sản phẩm (Bottom Sheet)
  void showProductDetail(Product p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thanh kéo
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Hình ảnh lớn
                    Center(
                      child: Container(
                        height: 250,
                        child: Image.network(
                          p.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Tên sản phẩm
                    Text(
                      p.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    // Category
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        p.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    // Rating chi tiết
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < p.rating.rate.floor() 
                              ? Icons.star 
                              : (index < p.rating.rate 
                                  ? Icons.star_half 
                                  : Icons.star_border),
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                        SizedBox(width: 8),
                        Text(
                          '${p.rating.rate} / 5.0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(${p.rating.count} đánh giá)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Giá
                    Text(
                      '\$${p.price}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),

                    SizedBox(height: 16),

                    Divider(),

                    // Mô tả
                    Text(
                      'Mô tả sản phẩm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      p.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 24),

                    // Nút Thêm vào giỏ hàng
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Xử lý thêm vào giỏ hàng
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Đã thêm "${p.title}" vào giỏ hàng'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.shopping_cart),
                        label: Text(
                          'Thêm vào giỏ hàng',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}