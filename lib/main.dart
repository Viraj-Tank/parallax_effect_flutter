import 'package:flutter/material.dart';
import 'package:parallax_effect/home_page.dart';

void main() {
  runApp(const ParallaxEffect());
}

class ParallaxEffect extends StatelessWidget {
  const ParallaxEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax Effect',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
