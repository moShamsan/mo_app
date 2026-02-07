import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../services/local_storage_service.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final isDark = app.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('الوضع الليلي (Dark Mode)'),
            value: isDark,
            onChanged: (_) => app.toggleTheme(),
          ),
          const Divider(),
          ListTile(
            title: const Text('اللغة (تجريبي)'), 
            subtitle: Text(LocalStorageService.instance.languageCode == 'ar'
                ? 'العربية'
                : 'English'),
            onTap: () async {
              final current = LocalStorageService.instance.languageCode;
              final next = current == 'ar' ? 'en' : 'ar';
              await LocalStorageService.instance.setLanguageCode(next);
              // ملاحظة: يمكن لاحقًا ربط هذا بـ localization حقيقي.
              // هنا فقط نخزن القيمة بحسب متطلبات المشروع.
              // تجاهل إعادة البناء المتقدم للاختصار.
              // يمكنك تحسينه لاحقًا في التوثيق كعمل مستقبلي.
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      next == 'ar'
                          ? 'تم اختيار اللغة العربية (نظريًا)'
                          : 'English language selected (theoretically)',
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

