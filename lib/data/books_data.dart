import 'package:flutter_application_1/models/book.dart';

/// بيانات ثابتة لكتب عن تاريخ وسياسة اليمن (احتياطي إذا لم يُحمّل JSON).
/// التطبيق يفضّل تحميل الكتب من lib/data/books.json عبر BooksLoader.
const List<Book> kAllBooks = [
  Book(
    id: 'b1',
    title: 'Yemen in Crisis: Autocracy, Neo-Liberalism and the Disintegration of a State',
    author: 'Helen Lackner',
    description:
        'دراسة عميقة حول جذور الأزمة اليمنية المعاصرة، تربط بين الأبعاد السياسية والاقتصادية والاجتماعية.',
    category: 'سياسي',
    era: 'اليمن المعاصر بعد الوحدة',
    coverAsset: 'assets/covers/default_yemen.png',
    externalUrl:
        'https://ar.wikipedia.org/wiki/%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE_%D8%A7%D9%84%D9%8A%D9%85%D9%86',
    source: 'SOAS Research Online',
  ),
  Book(
    id: 'b2',
    title: "The Historical Dimensions of Yemen's Civil War",
    author: 'Asher Orkaby',
    description:
        'عرض تاريخي موجز للحروب الأهلية في اليمن مع التركيز على العوامل التاريخية المؤثرة في النزاع.',
    category: 'تاريخي',
    era: 'القرن العشرون',
    coverAsset: 'assets/covers/default_yemen.png',
    externalUrl:
        'https://ar.wikipedia.org/wiki/%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE_%D8%A7%D9%84%D9%8A%D9%85%D9%86',
    source: 'Middle East Institute',
  ),
  Book(
    id: 'b3',
    title: 'Yemen: The Politics of Dependency',
    author: 'Abdulghani Al-Iryani',
    description:
        'تحليل للعلاقات السياسية والاقتصادية الخارجية لليمن وتأثير الاعتماد على المعونات على القرار السياسي.',
    category: 'سياسي',
    era: 'اليمن الجمهوري',
    coverAsset: 'assets/covers/default_yemen.png',
    externalUrl:
        'https://ar.wikipedia.org/wiki/%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE_%D8%A7%D9%84%D9%8A%D9%85%D9%86',
    source: 'Carnegie Endowment',
  ),
  Book(
    id: 'b4',
    title: 'Tribes and Politics in Yemen',
    author: 'Marieke Brandt',
    description:
        'يتناول دور القبيلة في تشكيل البنية السياسية والاجتماعية في اليمن، مع دراسة ميدانية معمّقة.',
    category: 'تاريخي',
    era: 'العصر الحديث',
    coverAsset: 'assets/covers/default_yemen.png',
    externalUrl:
        'https://ar.wikipedia.org/wiki/%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE_%D8%A7%D9%84%D9%8A%D9%85%D9%86',
    source: 'GPPi',
  ),
  Book(
    id: 'b5',
    title: 'Yemen: Revolution, Civil War and Unification',
    author: 'Stephen W. Day',
    description:
        'قراءة شاملة لمسار الثورة والجمهورية والحرب الأهلية والوحدة اليمنية من منظور تاريخي وسياسي.',
    category: 'تاريخي',
    era: 'الثورة والجمهورية والوحدة',
    coverAsset: 'assets/covers/default_yemen.png',
    externalUrl:
        'https://ar.wikipedia.org/wiki/%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE_%D8%A7%D9%84%D9%8A%D9%85%D9%86',
    source: 'Digital Commons',
  ),
];
