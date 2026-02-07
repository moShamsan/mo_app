import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/book.dart';
import '../providers/app_provider.dart';

class BookDetailsScreen extends StatefulWidget {
  static const routeName = '/book-details';

  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  final _noteController = TextEditingController();
  bool _noteLoading = false;
  bool _noteLoadRequested = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadNote(AppProvider app, String bookId) async {
    setState(() {
      _noteLoading = true;
    });
    final note = await app.getNote(bookId) ?? '';
    if (mounted) {
      setState(() {
        _noteController.text = note;
        _noteLoading = false;
      });
    }
  }

  Future<void> _openExternal(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر فتح الرابط، تحقق من الاتصال أو الرابط.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)?.settings.arguments as Book?;
    final app = context.watch<AppProvider>();

    if (book == null) {
      return const Scaffold(
        body: Center(child: Text('لا توجد بيانات كتاب لعرضها')),
      );
    }

    final isFavorite = app.favoriteIds.contains(book.id);

    if (!_noteLoadRequested) {
      _noteLoadRequested = true;
      _loadNote(app, book.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () => app.toggleFavorite(book.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  book.coverAsset,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.menu_book_rounded, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.author,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${book.category} • ${book.era}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'المصدر: ${book.source}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'وصف الكتاب:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(book.description),
            const SizedBox(height: 24),
            const Text(
              'رابط خارجي للكتاب أو المصدر:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            SelectableText(
              book.externalUrl,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await app.addToHistory(book.id);
                  await _openExternal(context, book.externalUrl);
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('فتح المصدر الخارجي'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ملاحظاتك الشخصية على الكتاب:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_noteLoading)
              const Center(child: CircularProgressIndicator())
            else
              TextField(
                controller: _noteController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'اكتب ملاحظاتك أو ملخصك الخاص عن الكتاب هنا...',
                ),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await app.saveNote(book.id, _noteController.text);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ الملاحظة بنجاح')),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('حفظ الملاحظة'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'اقتراحات (AI Recommendation – نظري):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'بناءً على تصنيف هذا الكتاب (${book.category}) والحقبة الزمنية (${book.era})، '
              'يمكن للنظام مستقبلاً استخدام خوارزميات توصية (Recommender Systems) '
              'لاقتراح كتب أخرى من نفس التصنيف أو من مصادر قريبة، اعتمادًا على سجل القراءة '
              'والمفضلة الخاصة بالمستخدم. هذا الجزء موضح نظريًا فقط في هذا المشروع.',
            ),
          ],
        ),
      ),
    );
  }
}

