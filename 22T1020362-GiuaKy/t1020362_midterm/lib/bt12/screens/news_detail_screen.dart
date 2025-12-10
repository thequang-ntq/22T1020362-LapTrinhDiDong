import 'package:flutter/material.dart';
import 'package:t1020362_midterm/bt12/model/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({super.key, required this.news});

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

  Future<void> openUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không thể mở link'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: w * 0.7,
            pinned: true,
            backgroundColor: const Color(0xFFFF6600),
            leading: Container(
              margin: EdgeInsets.all(w * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: w * 0.02,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFFF6600)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(w * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: w * 0.02,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border, color: Color(0xFFFF6600)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã lưu bài viết')),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: w * 0.02, top: w * 0.02, bottom: w * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: w * 0.02,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Color(0xFFFF6600)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chia sẻ bài viết')),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'news_image_${news.url}',
                child: Image.network(
                  news.urlToImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      '../../../assets/images/bt12/placeholder.jpg', // ảnh dự phòng
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03,
                          vertical: w * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6600),
                          borderRadius: BorderRadius.circular(w * 0.01),
                        ),
                        child: Text(
                          news.source.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.032,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time,
                        size: w * 0.04,
                        color: Colors.grey,
                      ),
                      SizedBox(width: w * 0.01),
                      Text(
                        formatTime(news.publishedAt),
                        style: TextStyle(
                          fontSize: w * 0.032,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w * 0.04),
                  Text(
                    news.title,
                    style: TextStyle(
                      fontSize: w * 0.055,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: w * 0.03),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: w * 0.03,
                        backgroundColor: const Color(0xFFFF6600).withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          size: w * 0.04,
                          color: const Color(0xFFFF6600),
                        ),
                      ),
                      SizedBox(width: w * 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tác giả',
                              style: TextStyle(
                                fontSize: w * 0.028,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              news.author,
                              style: TextStyle(
                                fontSize: w * 0.035,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w * 0.04),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  SizedBox(height: w * 0.04),
                  Text(
                    'Mô tả',
                    style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: w * 0.02),
                  Text(
                    news.description,
                    style: TextStyle(
                      fontSize: w * 0.038,
                      color: Colors.grey[800],
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: w * 0.04),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  SizedBox(height: w * 0.04),
                  Text(
                    'Nội dung',
                    style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: w * 0.02),
                  Text(
                    news.content,
                    style: TextStyle(
                      fontSize: w * 0.038,
                      color: Colors.grey[800],
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: w * 0.06),
                  Container(
                    padding: EdgeInsets.all(w * 0.04),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5F0),
                      borderRadius: BorderRadius.circular(w * 0.03),
                      border: Border.all(
                        color: const Color(0xFFFF6600).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFFFF6600),
                          size: w * 0.05,
                        ),
                        SizedBox(width: w * 0.03),
                        Expanded(
                          child: Text(
                            'Nhấn nút bên dưới để đọc toàn bộ bài viết gốc',
                            style: TextStyle(
                              fontSize: w * 0.035,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: w * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: w * 0.12,
            child: ElevatedButton.icon(
              onPressed: () => openUrl(context, news.url),
              icon: Icon(Icons.open_in_new, size: w * 0.05),
              label: Text(
                'Đọc bài viết đầy đủ',
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6600),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.02),
                ),
                elevation: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}