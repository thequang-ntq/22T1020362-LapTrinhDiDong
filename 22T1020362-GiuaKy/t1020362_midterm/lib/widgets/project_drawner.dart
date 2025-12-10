import 'package:flutter/material.dart';

class ProjectDrawer extends StatelessWidget {
  const ProjectDrawer({super.key});

  // Danh sách projects - bạn có thể thêm/sửa ở đây
  static const List<Map<String, String>> projects = [
    {'title': 'Bài 1', 'date': '24/09/2025', 'name': 'Bài mở đầu', 'route': '/project1'},
    {'title': 'Bài 2', 'date': '01/10/2025', 'name': 'My Place', 'route': '/project2'},
    {'title': 'Bài 3', 'date': '08/10/2025', 'name': 'My Classroom', 'route': '/project3'},
    {'title': 'Bài 4', 'date': '22/10/2025', 'name': 'Guide To Layout', 'route': '/project4'},
    {'title': 'Bài 5', 'date': '05/11/2025', 'name': 'Counter App', 'route': '/project5'},
    {'title': 'Bài 6', 'date': '05/11/2025', 'name': 'Color Change App', 'route': '/project6'},
    {'title': 'Bài 7', 'date': '12/11/2025', 'name': 'Login Form', 'route': '/project7'},
    {'title': 'Bài 8', 'date': '12/11/2025', 'name': 'Register Form', 'route': '/project8'},
    {'title': 'Bài 9', 'date': '19/11/2025', 'name': 'BMI Form', 'route': '/project9'},
    {'title': 'Bài 10', 'date': '19/11/2025', 'name': 'Feedback Form', 'route': '/project10'},
    {'title': 'Bài 11', 'date': '26/11/2025', 'name': 'API Example', 'route': '/project11'},
    {'title': 'Bài 12', 'date': '03/12/2025', 'name': 'News App', 'route': '/project12'},
    {'title': 'Bài 13', 'date': '10/12/2025', 'name': 'API Login Form', 'route': '/project13'},
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    
    return Drawer(
      child: Column(
        children: [
          // Header của Drawer
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "../../assets/images/avatar.jpg",
                      width: w * 0.15,
                      height: w * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: h * 0.005),
                  Text(
                    'Danh sách Projects',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.035,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Danh sách projects
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: h * 0.01),
              itemCount: projects.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: w * 0.04,
                endIndent: w * 0.04,
              ),
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    '${project['title']} (${project['date']})',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: w * 0.0375,
                    ),
                  ),
                  subtitle: Text(
                    project['name']!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: w * 0.0325,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: w * 0.04,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Uncomment dòng dưới khi đã tạo các trang project
                    Navigator.pushNamed(context, project['route']!);
                    
                    // Tạm thời hiển thị thông báo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Chuyển đến: ${project['name']}'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Footer với thông tin
          Container(
            padding: EdgeInsets.all(w * 0.04),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                top: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school,
                  size: w * 0.04,
                  color: Colors.grey[600],
                ),
                SizedBox(width: w * 0.02),
                Text(
                  '${projects.length} Projects',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: w * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}