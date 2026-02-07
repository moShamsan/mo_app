import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import 'books_list_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final userName = app.userName ?? 'مكتبة التاريخ السياسي لليمن';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yemen History Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              accountName: Text(userName),
              accountEmail: Text(app.userEmail ?? ''),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('الملف الشخصي'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('الإعدادات'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مرحبًا، $userName',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'استكشف كتب التاريخ والسياسة اليمنية عبر أقسام سهلة الاستخدام.',
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _HomeCard(
                    icon: Icons.flag,
                    title: 'الكتب السياسية',
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        BooksListScreen.routeName,
                        arguments: const BooksListArgs(
                          title: 'الكتب السياسية',
                          filterCategory: 'سياسي',
                        ),
                      );
                    },
                  ),
                  _HomeCard(
                    icon: Icons.history_edu,
                    title: 'الكتب التاريخية',
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        BooksListScreen.routeName,
                        arguments: const BooksListArgs(
                          title: 'الكتب التاريخية',
                          filterCategory: 'تاريخي',
                        ),
                      );
                    },
                  ),
                  _HomeCard(
                    icon: Icons.timeline,
                    title: 'حسب الفترات الزمنية',
                    color: Colors.teal,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        BooksListScreen.routeName,
                        arguments: const BooksListArgs(
                          title: 'الفترات الزمنية',
                          filterByEra: true,
                        ),
                      );
                    },
                  ),
                  _HomeCard(
                    icon: Icons.favorite,
                    title: 'المفضلة',
                    color: Colors.pinkAccent,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        BooksListScreen.routeName,
                        arguments: const BooksListArgs(
                          title: 'المفضلة',
                          favoritesOnly: true,
                        ),
                      );
                    },
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

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

