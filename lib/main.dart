import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/account/presentation/widgets/account_list/myorder.dart';
import 'package:techbox/src/features/location/presentation/widget/test.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: LocationTestWidget(),
    );
  }
}
