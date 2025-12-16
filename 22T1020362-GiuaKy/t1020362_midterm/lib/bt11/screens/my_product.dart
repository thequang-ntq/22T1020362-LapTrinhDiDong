import 'package:t1020362_midterm/bt11/api/api.dart';
import 'package:t1020362_midterm/bt11/model/product.dart';
import 'package:flutter/material.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  //Tải tất cả dữ liệu sản phẩm
  Future<void> loadProducts() async {
    setState(() {
      isLoading = true; // Bắt đầu loading
    });
    
    final products = await testAPI.getAllProduct();
    
    setState(() {
      allProducts = products;
      filteredProducts = products;
      isLoading = false; // Kết thúc loading
    });
  }

  //Lọc sản phẩm
  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = allProducts;
      } 
      else {
        filteredProducts = allProducts.where((product) {
          final searchLower = query.toLowerCase();
          return product.title.toLowerCase().contains(searchLower) ||
              product.description.toLowerCase().contains(searchLower) ||
              product.category.toLowerCase().contains(searchLower) ||
              product.price.toString().contains(searchLower) ||
              product.rating.rate.toString().contains(searchLower) ||
              product.rating.count.toString().contains(searchLower);
        }).toList();
      }
    });
  }
  
  //Hiển thị snackbar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
      ),
    );
  }

  //Giao diện
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: _buildAppBar(w),
      // Thay thế toàn bộ phần body từ dòng 95-118:
      body: Column(
        children: [
          _buildSearchBar(w),
          Expanded(
            child: isLoading // Kiểm tra trạng thái loading
              ?
              // Màn hình loading
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6600)),
                      strokeWidth: 3,
                    ),
                    SizedBox(height: h * 0.02),
                    Text(
                      'Đang tải sản phẩm...',
                      style: TextStyle(
                        fontSize: w * 0.04,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
              :
              // Nội dung khi đã load xong
              filteredProducts.isEmpty
                ? 
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off, size: w * 0.16, 
                        color: Colors.grey,
                      ),
                      SizedBox(height: h * 0.02),
                      Text(
                        'Không tìm thấy sản phẩm',
                        style: TextStyle(
                          fontSize: w * 0.04,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
                : 
                myGridView(filteredProducts, w, h),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(w),
    );
  }

  //Tạo AppBar (thanh AppBar ở đầu)
  PreferredSizeWidget _buildAppBar(double w) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: w * 0.18,
      title: Row(
        children: [
          // Logo FakeLazada
          Container(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: w * 0.015),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6600), Color(0xFFFF9933)],
              ),
              borderRadius: BorderRadius.circular(w * 0.02),
            ),
            child: Text(
              "FakeLazada",
              style: TextStyle(
                fontSize: w * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Spacer(),
          // Icon giỏ hàng
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined, 
              color: Color(0xFFFF6600),
              size: w * 0.065,
            ),
            onPressed: () {
              showSnackBar("Đã bấm vào nút mua hàng");
            },
          ),
          // Icon chat
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, 
              color: Color(0xFFFF6600),
              size: w * 0.065,
            ),
            onPressed: () {
              showSnackBar("Đã bấm vào nút trò chuyện (chat)");
            },
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ], 
    );
  }

  //Tạo thanh tìm kiếm
  Widget _buildSearchBar(double w) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        w * 0.03, 
        0, 
        w * 0.03, 
        w * 0.03
      ),
      child: Container(
        height: w * 0.11,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(w * 0.01),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            SizedBox(width: w * 0.03),
            Icon(
              Icons.search, 
              color: Colors.grey[600], 
              size: w * 0.055
            ),
            SizedBox(width: w * 0.02),
            Expanded(
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  filterProducts(value);
                },
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500], 
                    fontSize: w * 0.035,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showSnackBar("Tính năng tìm kiếm bằng hình ảnh");
              },
              child: Container(
                height: w * 0.11,
                width: w * 0.15,
                decoration: BoxDecoration(
                  color: Color(0xFFFF6600),
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(w * 0.01)),
                ),
                child: Icon(
                  Icons.camera_alt_outlined, 
                  color: Colors.white, 
                  size: w * 0.05
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Danh sách sản phẩm theo GridView, hiển thị toàn bộ hoặc các sản phẩm được tìm kiếm ra
  Widget myGridView(List<Product> ls, double w, double h) {
    return GridView.builder(
      padding: EdgeInsets.all(w * 0.02),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: w * 0.02,
        mainAxisSpacing: w * 0.02,
      ),
      itemCount: ls.length,
      itemBuilder: (context, index) {
        return myItem(ls[index], w);
      },
    );
  }

  //Sản phẩm trong danh sách sản phẩm GridView ở trên
  Widget myItem(Product p, double w) {
    return GestureDetector(
      onTap: () {
        //Hiển thị modal chi tiết sản phẩm
        showProductDetail(p, w);
      },
      //Vỏ card
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.01),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: w * 0.01,
              offset: Offset(0, w * 0.005),
            ),
          ],
        ),
        //Giao diện chi tiết trong card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm với chữ giảm giá
            Stack(
              children: [
                Container(
                  height: w * 0.35,
                  width: double.infinity,
                  padding: EdgeInsets.all(w * 0.02),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(w * 0.01)),
                    child: Image.network(
                      p.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        //Ảnh nếu ảnh sản phẩm bị lỗi
                        return Icon(
                          Icons.broken_image, 
                          size: w * 0.12, 
                          color: Colors.grey
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6600)),
                            value: loadingProgress.expectedTotalBytes != null
                              ? 
                              loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : 
                              null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Chữ giảm giá
                Positioned(
                  top: w * 0.02,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.015, vertical: w * 0.008),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6600),
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(w * 0.01)),
                    ),
                    child: Text(
                      '-${(10 + (p.price % 30)).toInt()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Chữ ship miễn phí
                if (p.price > 20)
                  Positioned(
                    bottom: w * 0.02,
                    left: w * 0.02,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.01, 
                        vertical: w * 0.005
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFF6600)),
                        borderRadius: BorderRadius.circular(w * 0.005),
                      ),
                      child: Text(
                        'Free Ship',
                        style: TextStyle(
                          color: Color(0xFFFF6600),
                          fontSize: w * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Thông tin chữ của sản phẩm
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  w * 0.02, 
                  w * 0.01, 
                  w * 0.02, 
                  w * 0.02
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tiêu đề
                    Text(
                      p.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.03,
                        height: 1.3,
                        color: Colors.black87,
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Giá
                        Row(
                          children: [
                            Text(
                              '\$',
                              style: TextStyle(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF6600),
                              ),
                            ),
                            Text(
                              '${p.price}',
                              style: TextStyle(
                                fontSize: w * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF6600),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: w * 0.01),

                        // Đánh giá và số lượt đã bán
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber[700], size: w * 0.03),
                            SizedBox(width: w * 0.005),
                            Text(
                              '${p.rating.rate}',
                              style: TextStyle(
                                fontSize: w * 0.028,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(width: w * 0.02),
                            Text(
                              '${p.rating.count} đã bán',
                              style: TextStyle(
                                fontSize: w * 0.028,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
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

  // Tạo BottomNav (Thanh BottomNav)
  Widget _buildBottomNav(double w) {
    return Container(
      height: w * 0.14,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: w * 0.02,
            offset: Offset(0, -w * 0.005),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Trang chủ', true, w),
          _buildNavItem(Icons.flash_on, 'Flash Sale', false, w),
          _buildNavItem(Icons.category_outlined, 'Danh mục', false, w),
          _buildNavItem(Icons.local_offer_outlined, 'Ưu đãi', false, w),
          _buildNavItem(Icons.person_outline, 'Tôi', false, w),
        ],
      ),
    );
  }

  //Tạo các item trong BottomNav
  Widget _buildNavItem(IconData icon, String label, bool isActive, double w) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Color(0xFFFF6600) : Colors.grey[600],
          size: w * 0.06,
        ),
        SizedBox(height: w * 0.01),
        Text(
          label,
          style: TextStyle(
            fontSize: w * 0.025,
            color: isActive ? Color(0xFFFF6600) : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  //Modal chi tiết sản phẩm
  void showProductDetail(Product p, double w) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(w * 0.05)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Xử lý phần thanh kéo
                          Center(
                            child: Container(
                              width: w * 0.1,
                              height: w * 0.012,
                              margin: EdgeInsets.symmetric(vertical: w * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(w * 0.008),
                              ),
                            ),
                          ),

                          // Section ảnh
                          Stack(
                            children: [
                              Container(
                                height: w * 0.75,
                                width: double.infinity,
                                color: Colors.white,
                                child: Image.network(
                                  p.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: w * 0.03,
                                right: w * 0.03,
                                child: Container(
                                  padding: EdgeInsets.all(w * 0.02),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: w * 0.02,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.share, 
                                    size: w * 0.05, 
                                    color: Colors.grey[700]
                                  ),
                                ),
                              ),
                              Positioned(
                                top: w * 0.03,
                                left: w * 0.03,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.03, 
                                    vertical: w * 0.015
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF6600),
                                    borderRadius: BorderRadius.circular(w * 0.01),
                                  ),
                                  child: Text(
                                    'Flash Sale',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: w * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Chi tiết sản phẩm
                          Padding(
                            padding: EdgeInsets.all(w * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section giá
                                Container(
                                  padding: EdgeInsets.all(w * 0.03),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFF5F0),
                                    borderRadius: BorderRadius.circular(w * 0.02),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '\$${p.price}',
                                            style: TextStyle(
                                              fontSize: w * 0.07,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFF6600),
                                            ),
                                          ),
                                          SizedBox(width: w * 0.03),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: w * 0.02, 
                                              vertical: w * 0.01
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF6600),
                                              borderRadius: BorderRadius.circular(w * 0.01),
                                            ),
                                            child: Text(
                                              '-${(10 + (p.price % 30)).toInt()}%',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: w * 0.032,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: w * 0.01),
                                      Row(
                                        children: [
                                          Text(
                                            '\$${(p.price * 1.3).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: w * 0.035,
                                              color: Colors.grey[600],
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: w * 0.015, 
                                              vertical: w * 0.005
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color(0xFFFF6600)),
                                              borderRadius: BorderRadius.circular(w * 0.008),
                                            ),
                                            child: Text(
                                              'Free Ship',
                                              style: TextStyle(
                                                color: Color(0xFFFF6600),
                                                fontSize: w * 0.025,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: w * 0.04),

                                // Tiêu đề
                                Text(
                                  p.title,
                                  style: TextStyle(
                                    fontSize: w * 0.045,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                ),

                                SizedBox(height: w * 0.03),

                                // Section rating
                                Container(
                                  padding: EdgeInsets.all(w * 0.03),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(w * 0.02),
                                  ),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < p.rating.rate.floor()
                                              ? 
                                              Icons.star
                                              : 
                                              (index < p.rating.rate
                                                ? 
                                                Icons.star_half
                                                : 
                                                Icons.star_border
                                              ),
                                            color: Colors.amber[700],
                                            size: w * 0.045,
                                          );
                                        }),
                                      ),
                                      SizedBox(width: w * 0.02),
                                      Text(
                                        '${p.rating.rate}/5',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: w * 0.035,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.04),
                                      Text(
                                        '${p.rating.count} đánh giá',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: w * 0.032,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${p.rating.count * 3} đã bán',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: w * 0.032,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: w * 0.04),

                                // Thể loại
                                Row(
                                  children: [
                                    Text(
                                      'Danh mục: ',
                                      style: TextStyle(
                                        fontSize: w * 0.035,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.025, 
                                        vertical: w * 0.012
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE8F5E9),
                                        borderRadius: BorderRadius.circular(w * 0.01),
                                      ),
                                      child: Text(
                                        p.category.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: w * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4CAF50),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: w * 0.05),

                                Divider(thickness: 1),

                                SizedBox(height: w * 0.03),

                                // Description (Mô tả)
                                Text(
                                  'Chi tiết sản phẩm',
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: w * 0.03),
                                Text(
                                  p.description,
                                  style: TextStyle(
                                    fontSize: w * 0.035,
                                    color: Colors.grey[800],
                                    height: 1.6,
                                  ),
                                ),

                                SizedBox(height: w * 0.06),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Nút Thêm vào giỏ hàng - Fixed bottom
                  Container(
                    padding: EdgeInsets.all(w * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: w * 0.02,
                          offset: Offset(0, -w * 0.005),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: w * 0.12,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showSnackBar('Đã thêm vào giỏ hàng');
                        },
                        icon: Icon(
                          Icons.shopping_cart, 
                          size: w * 0.05
                        ),
                        label: Text(
                          'Thêm vào giỏ hàng',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6600),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.02),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}