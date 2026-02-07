import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';

class BooksLoader {
  BooksLoader._();

  static Future<List<Book>> loadFromJson() async {
    final jsonString = await rootBundle.loadString('lib/data/books.json');
    final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
    return decoded
        .map((e) => Book.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

