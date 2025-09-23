import 'package:flutter/material.dart';
import 'package:flutter_srf/ui/components/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SRF',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: const HomeScreen(), // 既存のUI（必要に応じて切り替え）
    );
  }
}
