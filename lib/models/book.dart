class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String category; // سياسي / تاريخي
  final String era; // الحقبة الزمنية
  final String coverAsset; // مسار الصورة من الأصول (assets)
  final String externalUrl; // رابط خارجي لمصدر الكتاب
  final String source; // اسم الجهة أو الموقع

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.era,
    required this.coverAsset,
    required this.externalUrl,
    required this.source,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      era: json['era'] as String,
      coverAsset: json['coverAsset'] as String,
      externalUrl: json['externalUrl'] as String,
      source: json['source'] as String,
    );
  }
}

