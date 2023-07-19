import 'package:flutter/material.dart';
class OneCategoryScreen extends StatefulWidget {
  const OneCategoryScreen({super.key});

  @override
  State<OneCategoryScreen> createState() => _OneCategoryScreenState();
}

class _OneCategoryScreenState extends State<OneCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("one category screen"),
        centerTitle: true,
      ),
    );
  }
}
