import 'package:flutter/material.dart';

import '../database/local_db.dart';
import '../models/book.dart';
import '../services/books_loader.dart';
import '../services/local_storage_service.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    _init();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  String? _userName;
  String? _userEmail;
  bool _loggedIn = false;

  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get isLoggedIn => _loggedIn;

  List<Book> _books = <Book>[];
  List<Book> get books => _books;

  final Set<String> _favoriteIds = <String>{};
  Set<String> get favoriteIds => _favoriteIds;

  final Map<String, String> _notes = <String, String>{};
  Map<String, String> get notes => _notes;

  List<String> _historyBookIds = <String>[];
  List<String> get historyBookIds => _historyBookIds;

  List<Book> get favoriteBooks =>
      _books.where((b) => _favoriteIds.contains(b.id)).toList();

  Future<void> _init() async {
    await LocalStorageService.instance.init();
    await LocalDb.instance.init();

    final mode = LocalStorageService.instance.themeMode;
    _themeMode = mode == 'dark' ? ThemeMode.dark : ThemeMode.light;

    _loggedIn = LocalStorageService.instance.isLoggedIn;
    _userName = LocalStorageService.instance.userName;
    _userEmail = LocalStorageService.instance.userEmail;

    _books = await BooksLoader.loadFromJson();

    final favIds = await LocalDb.instance.getFavoriteBookIds();
    _favoriteIds
      ..clear()
      ..addAll(favIds);

    _historyBookIds = await LocalDb.instance.getHistoryBookIds();

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await LocalStorageService.instance
        .setThemeMode(_themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  Future<void> register(String email, String password, String name) async {
    _setLoading(true);
    try {
      // تخزين بيانات المستخدم محليًا (محاكاة لنظام تسجيل مستخدمين بدون أي API)
      await LocalStorageService.instance.setUserEmail(email);
      await LocalStorageService.instance.setUserPassword(password);
      await LocalStorageService.instance.setUserName(name);
      await LocalStorageService.instance.setLoggedIn(true);

      _userEmail = email;
      _userName = name;
      _loggedIn = true;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final storedEmail = LocalStorageService.instance.userEmail;
      final storedPassword = LocalStorageService.instance.userPassword;
      if (storedEmail == null || storedPassword == null) {
        throw Exception('لا يوجد حساب مسجل، الرجاء إنشاء حساب أولاً.');
      }
      if (storedEmail != email || storedPassword != password) {
        throw Exception('بيانات الدخول غير صحيحة.');
      }

      await LocalStorageService.instance.setLoggedIn(true);
      _loggedIn = true;
      _userEmail = storedEmail;
      _userName = LocalStorageService.instance.userName;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _loggedIn = false;
    await LocalStorageService.instance.setLoggedIn(false);
    notifyListeners();
  }

  Future<void> toggleFavorite(String bookId) async {
    await LocalDb.instance.toggleFavorite(bookId);
    if (_favoriteIds.contains(bookId)) {
      _favoriteIds.remove(bookId);
    } else {
      _favoriteIds.add(bookId);
    }
    notifyListeners();
  }

  Future<void> addToHistory(String bookId) async {
    await LocalDb.instance.addToHistory(bookId);
    _historyBookIds.insert(0, bookId);
    notifyListeners();
  }

  Future<String?> getNote(String bookId) async {
    if (_notes.containsKey(bookId)) return _notes[bookId];
    final note = await LocalDb.instance.getNote(bookId);
    if (note != null) {
      _notes[bookId] = note;
    }
    return note;
  }

  Future<void> saveNote(String bookId, String content) async {
    await LocalDb.instance.upsertNote(bookId, content);
    _notes[bookId] = content;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

