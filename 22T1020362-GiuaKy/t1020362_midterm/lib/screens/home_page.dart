import 'package:flutter/material.dart';
import 'package:t1020362_midterm/widgets/project_drawner.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '22T1020362 - Nguyễn Thế Quang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: w * 0.04,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      drawer: const ProjectDrawer(),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(w * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_special,
                    size: w * 0.3,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ),
                  SizedBox(height: h * 0.03),
                  Text(
                    'Các dự án đã làm',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  SizedBox(height: h * 0.02),
                  Text(
                    'Mở menu bên trái để xem các project',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.04),
                  ElevatedButton.icon(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                    label: const Text('Mở Menu'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.08,
                        vertical: h * 0.02,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}