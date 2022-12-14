import 'package:flutter/material.dart';

class CenterWidget extends StatelessWidget {
  final BoxConstraints constraints;

  const CenterWidget({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PanelView(child: BoardView(constraints));
  }
}
