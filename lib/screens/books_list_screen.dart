import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/app_provider.dart';
import '../widgets/book_card.dart';
import 'book_details_screen.dart';

class BooksListArgs {
  final String title;
  final String? filterCategory;
  final bool favoritesOnly;
  final bool filterByEra;

  const BooksListArgs({
    required this.title,
    this.filterCategory,
    this.favoritesOnly = false,
    this.filterByEra = false,
  });
}

class BooksListScreen extends StatefulWidget {
  static const routeName = '/books';

  const BooksListScreen({super.key});

  @override
  State<BooksListScreen> createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  String _query = '';
  String? _selectedEra;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BooksListArgs? ??
            const BooksListArgs(title: 'الكتب');
    final app = context.watch<AppProvider>();
    List<Book> books = app.books;

    if (args.filterCategory != null) {
      books = books
          .where((b) => b.category == args.filterCategory)
          .toList();
    }

    if (args.favoritesOnly) {
      final favIds = app.favoriteBooks.map((b) => b.id).toSet();
      books = books.where((b) => favIds.contains(b.id)).toList();
    }

    final eras = books.map((b) => b.era).toSet().toList();

    if (_selectedEra != null) {
      books = books.where((b) => b.era == _selectedEra).toList();
    }

    if (_query.isNotEmpty) {
      books = books
          .where((b) =>
              b.title.toLowerCase().contains(_query.toLowerCase()) ||
              b.author.toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'بحث في الكتب أو المؤلفين...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          if (args.filterByEra && eras.isNotEmpty)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: eras.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: const Text('الكل'),
                        selected: _selectedEra == null,
                        onSelected: (_) {
                          setState(() {
                            _selectedEra = null;
                          });
                        },
                      ),
                    );
                  }
                  final era = eras[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(era),
                      selected: _selectedEra == era,
                      onSelected: (_) {
                        setState(() {
                          _selectedEra = era;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: books.isEmpty
                ? const Center(child: Text('لا توجد كتب مطابقة حاليًا'))
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: books.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final book = books[index];
                      final isFav =
                          app.favoriteBooks.any((b) => b.id == book.id);
                      return BookCard(
                        book: book,
                        isFavorite: isFav,
                        onFavoriteToggle: () =>
                            app.toggleFavorite(book.id),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            BookDetailsScreen.routeName,
                            arguments: book,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

