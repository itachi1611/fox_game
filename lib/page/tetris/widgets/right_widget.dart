import 'package:flutter/material.dart';

class RightWidget extends StatelessWidget {
  const RightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pieces = context.watch<Board>().nextPieces;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        PanelView(
          topLeft: false,
          bottomLeft: false,
          child: Column(
            children: [
              const Text('NEXT'),
              ...pieces.take(3).map((p) => PieceView(piece: p))
            ],
          ),
        ),
      ],
    );
  }
}