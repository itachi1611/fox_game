import 'package:flutter/material.dart';

import '../../widgets/search_bar_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SearchBarWidget(),
      ],
    );
  }
}
