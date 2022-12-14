import 'package:flutter/material.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final piece = context.select<Board, Piece?>((value) => value.holdPiece);
    final lines = context.select<Board, int>((value) => value.clearedLines);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        PanelView(
          topRight: false,
          bottomRight: false,
          child: Column(
            children: [const Text('HOLD'), PieceView(piece: piece)],
          ),
        ),
        const SizedBox(height: 50),
        PanelView(
          topRight: false,
          bottomRight: false,
          child: Column(
            children: [
              const Text('LEVEL'),
              Text('${getLevel(lines).id}'),
              const SizedBox(height: 10),
              const Text('LINES'),
              Text('$lines'),
            ],
          ),
        ),
      ],
    );
  }
}