import 'package:fluent_ui/fluent_ui.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'homepage.dart';
import 'model/transaction.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transaction');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Magg',
      theme: ThemeData(),
      home: const HomePage(title: 'Magg reader'),
    );
  }
}
