import 'package:flutter/material.dart';
import 'package:money_management_app/pages/add.dart';
import 'package:money_management_app/pages/main_page.dart';
import 'package:money_management_app/pages/settings.dart';
import 'package:money_management_app/providers/transactions_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money management application',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/add': ((context) => AddTransactionPage()),
        '/settings': (context) => const Settings(),
      },
    );
  }
}

