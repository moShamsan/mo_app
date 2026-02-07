import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../services/local_storage_service.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 70);
    if (picked == null) return;

    setState(() {
      _imageFile = File(picked.path);
    });

    await LocalStorageService.instance.setUserPhotoPath(picked.path);
  }

  @override
  void initState() {
    super.initState();
    final localPath = LocalStorageService.instance.userPhotoPath;
    if (localPath != null && File(localPath).existsSync()) {
      _imageFile = File(localPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : null,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 48)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: PopupMenuButton<ImageSource>(
                    icon: const CircleAvatar(
                      radius: 16,
                      child: Icon(Icons.camera_alt, size: 16),
                    ),
                    onSelected: (source) => _pickImage(source),
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: ImageSource.camera,
                        child: Text('الكاميرا'),
                      ),
                      PopupMenuItem(
                        value: ImageSource.gallery,
                        child: Text('المعرض'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 16),
            Text(
              app.userName ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(app.userEmail ?? ''),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await app.signOut();
                  if (!mounted) return;
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.logout),
                label: const Text('تسجيل الخروج'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

