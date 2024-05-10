import 'package:flutter/material.dart';
import 'package:parallax_effect/list_view_parallax.dart';
import 'package:parallax_effect/page_view_parallax.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedType = 'L';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Parallax Effect',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 'L',
                        groupValue: selectedType,
                        onChanged: (val) => setState(() => selectedType = 'L'),
                      ),
                      const Text('ListView'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 'P',
                        groupValue: selectedType,
                        onChanged: (val) => setState(() => selectedType = 'P'),
                      ),
                      const Text('PageView'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: selectedType == 'L' ? ListViewParallax() : PageViewParallax())
        ],
      ),
    );
  }
}
