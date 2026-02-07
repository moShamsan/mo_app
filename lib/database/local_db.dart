import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDb {
  LocalDb._();

  static final LocalDb instance = LocalDb._();

  Database? _db;

  Future<void> init() async {
    if (_db != null) return;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'yemen_library.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            book_id TEXT PRIMARY KEY
          );
        ''');
        await db.execute('''
          CREATE TABLE history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            book_id TEXT,
            opened_at INTEGER
          );
        ''');
        await db.execute('''
          CREATE TABLE notes (
            book_id TEXT PRIMARY KEY,
            content TEXT
          );
        ''');
      },
    );
  }

  Database get db {
    if (_db == null) {
      throw StateError('Database not initialized. Call init() first.');
    }
    return _db!;
  }

  // Favorites
  Future<List<String>> getFavoriteBookIds() async {
    final maps = await db.query('favorites');
    return maps.map((e) => e['book_id'] as String).toList();
  }

  Future<void> toggleFavorite(String bookId) async {
    final existing = await db.query(
      'favorites',
      where: 'book_id = ?',
      whereArgs: [bookId],
    );
    if (existing.isEmpty) {
      await db.insert('favorites', {'book_id': bookId});
    } else {
      await db.delete(
        'favorites',
        where: 'book_id = ?',
        whereArgs: [bookId],
      );
    }
  }

  // History
  Future<void> addToHistory(String bookId) async {
    await db.insert('history', {
      'book_id': bookId,
      'opened_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<String>> getHistoryBookIds() async {
    final maps = await db.query(
      'history',
      orderBy: 'opened_at DESC',
      limit: 50,
    );
    return maps.map((e) => e['book_id'] as String).toList();
  }

  // Notes
  Future<String?> getNote(String bookId) async {
    final maps = await db.query(
      'notes',
      where: 'book_id = ?',
      whereArgs: [bookId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return maps.first['content'] as String?;
  }

  Future<void> upsertNote(String bookId, String content) async {
    await db.insert(
      'notes',
      {'book_id': bookId, 'content': content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

