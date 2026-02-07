import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/books_list_screen.dart';
import 'screens/book_details_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const YemenHistoryApp());
}

class YemenHistoryApp extends StatelessWidget {
  const YemenHistoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Consumer<AppProvider>(
        builder: (context, app, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Yemen History & Politics Library',
            themeMode: app.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
              useMaterial3: true,
              brightness: Brightness.light,
              fontFamily: 'Roboto',
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              brightness: Brightness.dark,
              fontFamily: 'Roboto',
            ),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (_) => const SplashScreen(),
              LoginScreen.routeName: (_) => const LoginScreen(),
              RegisterScreen.routeName: (_) => const RegisterScreen(),
              HomeScreen.routeName: (_) => const HomeScreen(),
              BooksListScreen.routeName: (_) => const BooksListScreen(),
              BookDetailsScreen.routeName: (_) => const BookDetailsScreen(),
              ProfileScreen.routeName: (_) => const ProfileScreen(),
              SettingsScreen.routeName: (_) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}

