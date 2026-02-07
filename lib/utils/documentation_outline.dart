/// ملف تجميعي لنقاط التوثيق المطلوبة في المشروع.
/// يمكن استخدام هذه النصوص كمرجع عند كتابة تقرير المشروع النهائي.
library;

const String kAbstract = '''
Yemen History & Politics Library هو تطبيق موبايل تعليمي مبني بتقنية Flutter
يهدف إلى توفير مكتبة رقمية للكتب والمراجع السياسية والتاريخية الخاصة بتاريخ اليمن
مع دعم تسجيل المستخدمين والتخزين السحابي والمحلي وتجربة استخدام حديثة.
''';

const String kIntroduction = '''
يأتي هذا المشروع استجابةً للحاجة إلى منصة رقمية موثوقة توثق التاريخ السياسي
والتاريخي لليمن بطريقة منظمة وسهلة الوصول، مستفيدة من تقنيات الهواتف الذكية
والخدمات السحابية الحديثة.
''';

const String kStateManagementExplanation = '''
تم استخدام نمط Provider لإدارة الحالة (State Management) بحيث يتم فصل منطق
الأعمال (Business Logic) عن واجهة المستخدم (UI). يوفر AppProvider حالة موحدة
للمستخدم والكتب والمفضلة والثيم، ويتم الاستماع لها في الشاشات المختلفة عبر
ChangeNotifierProvider و Consumer.
''';

const String kResults = '''
يوفر التطبيق مكتبة مصنفة تحتوي على كتب سياسية وتاريخية متخصصة عن اليمن، مع
إمكانية البحث، وتصنيف الكتب بحسب الفئة أو الحقبة الزمنية، وإدارة قائمة مفضلة
وسجل قراءة للمستخدم.
''';

const String kFutureWork = '''
يمكن تطوير المشروع مستقبلاً من خلال:
- ربط نظام توصية حقيقي يعتمد على الذكاء الاصطناعي لتحليل سلوك المستخدم.
- إضافة دعم كامل لتعدد اللغات (Localization).
- مزامنة سجل القراءة والمفضلة مع Firestore ليعمل على أكثر من جهاز.
- توسيع قاعدة البيانات لتشمل مزيدًا من الكتب والوثائق.
''';

const String kConclusion = '''
قدم المشروع تجربة رقمية مبسطة وحديثة للوصول إلى مصادر التاريخ والسياسة اليمنية،
مع الالتزام بأفضل ممارسات تصميم التطبيقات من حيث تقسيم الشفرات وإدارة الحالة
والتكامل مع الخدمات السحابية والتخزين المحلي.
''';

const String kReferences = '''
- Helen Lackner, Yemen in Crisis: Autocracy, Neo-Liberalism and the Disintegration of a State.
- Stephen W. Day, Yemen: Revolution, Civil War and Unification.
- Marieke Brandt, Tribes and Politics in Yemen.
- Asher Orkaby, The Historical Dimensions of Yemen's Civil War.
- وثائق ودراسات منشورة في مراكز أبحاث دولية حول اليمن.
''';

