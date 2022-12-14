import 'package:flutter/material.dart';

class PieceWidget extends StatelessWidget {
  final Piece? piece;

  const PieceWidget({required this.piece, super.key});

  @override
  Widget build(BuildContext context) => Container(
        constraints: const BoxConstraints(minHeight: 30),
        child: piece != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  piece!.height,
                  (y) => Row(
                    children: List.generate(
                      piece!.width,
                      (x) => SizedBox.fromSize(
                        size: const Size(5, 5),
                        child: Container(
                            color: piece!.tiles
                                    .where((element) => element == Vector(x, y))
                                    .isEmpty
                                ? Colors.transparent
                                : Colors.white),
                      ),
                    ),
                  ),
                ).reversed.toList(),
              )
            : const SizedBox.shrink(),
      );
}
