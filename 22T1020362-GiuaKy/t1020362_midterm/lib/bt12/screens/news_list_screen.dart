import 'package:flutter/material.dart';
import 'package:t1020362_midterm/bt12/data/api.dart';
import 'package:t1020362_midterm/bt12/model/news.dart';
import 'package:t1020362_midterm/bt12/screens/news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  List<News> allNews = [];
  List<News> filteredNews = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadNews() async {
    setState(() => isLoading = true);
    final news = await testAPI.getAllNews();
    setState(() {
      allNews = news;
      filteredNews = news;
      isLoading = false;
    });
  }

  void filterNews(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredNews = allNews;
      } else {
        filteredNews = allNews.where((news) {
          final searchLower = query.toLowerCase();
          return news.title.toLowerCase().contains(searchLower) ||
              news.description.toLowerCase().contains(searchLower) ||
              news.author.toLowerCase().contains(searchLower) ||
              news.source.name.toLowerCase().contains(searchLower);
        }).toList();
      }
    });
  }

  Future<void> searchNewNews(String query) async {
    if (query.isEmpty) {
      loadNews();
      return;
    }
    
    setState(() => isLoading = true);
    final news = await testAPI.searchNews(query);
    setState(() {
      allNews = news;
      filteredNews = news;
      isLoading = false;
    });
  }

  String formatTime(String dateTime) {
    try {
      final date = DateTime.parse(dateTime);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} ngày trước';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} giờ trước';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} phút trước';
      } else {
        return 'Vừa xong';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
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
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(w),
      body: Column(
        children: [
          _buildSearchBar(w),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6600)),
                    ),
                  )
                : filteredNews.isEmpty
                    ? _buildEmptyState(w, h)
                    : RefreshIndicator(
                        onRefresh: loadNews,
                        color: const Color(0xFFFF6600),
                        child: ListView.builder(
                          padding: EdgeInsets.all(w * 0.03),
                          itemCount: filteredNews.length,
                          itemBuilder: (context, index) {
                            return _buildNewsCard(filteredNews[index], w);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double w) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: w * 0.18,
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.03,
              vertical: w * 0.015,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6600), Color(0xFFFF9933)],
              ),
              borderRadius: BorderRadius.circular(w * 0.02),
            ),
            child: Row(
              children: [
                Icon(Icons.newspaper, color: Colors.white, size: w * 0.05),
                SizedBox(width: w * 0.02),
                Text(
                  "BT12-NewsApp",
                  style: TextStyle(
                    fontSize: w * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: const Color(0xFFFF6600),
              size: w * 0.065,
            ),
            onPressed: () {
              showSnackBar("Danh sách đã lưu");
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: const Color(0xFFFF6600),
              size: w * 0.065,
            ),
            onPressed: () {
              showSnackBar("Thông báo");
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

  Widget _buildSearchBar(double w) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(w * 0.03, 0, w * 0.03, w * 0.03),
      child: Container(
        height: w * 0.11,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(w * 0.01),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            SizedBox(width: w * 0.03),
            Icon(Icons.search, color: Colors.grey[600], size: w * 0.055),
            SizedBox(width: w * 0.02),
            Expanded(
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  searchNewNews(value);
                },
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm tin tức...',
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
                if (searchController.text.isNotEmpty) {
                  searchNewNews(searchController.text);
                }
              },
              child: Container(
                height: w * 0.11,
                width: w * 0.15,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6600),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(w * 0.01),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: w * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(double w, double h) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article_outlined, size: w * 0.16, color: Colors.grey),
          SizedBox(height: h * 0.02),
          Text(
            'Không tìm thấy tin tức',
            style: TextStyle(
              fontSize: w * 0.04,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(News news, double w) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(news: news),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: w * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: w * 0.02,
              offset: Offset(0, w * 0.01),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(w * 0.03),
              ),
              child: Hero(
                tag: 'news_image_${news.url}',
                child: Image.network(
                  news.urlToImage,
                  width: double.infinity,
                  height: w * 0.5,
                  fit: BoxFit.cover,

                  // Nếu ảnh bị chặn (CORS) hoặc không tải được → dùng ảnh assets
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/bt12/placeholder.jpg',
                      width: double.infinity,
                      height: w * 0.5,
                      fit: BoxFit.cover,
                    );
                  },

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: w * 0.5,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFFF6600),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ),
            Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.02,
                          vertical: w * 0.008,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6600).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(w * 0.01),
                        ),
                        child: Text(
                          news.source.name,
                          style: TextStyle(
                            color: const Color(0xFFFF6600),
                            fontSize: w * 0.028,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.02),
                      Icon(Icons.access_time, size: w * 0.03, color: Colors.grey),
                      SizedBox(width: w * 0.01),
                      Text(
                        formatTime(news.publishedAt),
                        style: TextStyle(
                          fontSize: w * 0.028,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w * 0.02),
                  Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: w * 0.042,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: w * 0.02),
                  Text(
                    news.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: w * 0.03),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: w * 0.04, color: Colors.grey),
                      SizedBox(width: w * 0.01),
                      Expanded(
                        child: Text(
                          news.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: w * 0.03,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: w * 0.04,
                        color: const Color(0xFFFF6600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}