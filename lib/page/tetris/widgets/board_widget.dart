import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget(this.constraints, {super.key});

  final BoxConstraints constraints;

  static const _divider = 1.0;

  @override
  Widget build(BuildContext context) {
    final tileDimension = voodooTileDimension(context);
    final width = tileDimension * Board.x + _divider * Board.x;
    final height = tileDimension * Board.y + _divider * Board.y;
    final gridSize = Size(width, height);

    final tiles = context.watch<Board>().getTiles();
    final gridItems = <Widget>[];
    for (var index = 0; index < tiles.length; index++) {
      BoxDecoration decoration;
      switch (tiles[index]) {
        case Tile.blank:
          decoration = const BoxDecoration(color: Colors.black);
          break;
        case Tile.blocked:
          decoration = const BoxDecoration(color: Colors.grey);
          break;
        case Tile.piece:
          final color = context.read<Board>().currentPiece.color;
          decoration = BoxDecoration(color: color);
          break;
        case Tile.ghost:
          decoration = BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.white,
              width: _divider,
            ),
          );
          break;
      }

      final item = Container(
        height: tileDimension,
        width: tileDimension,
        decoration: decoration,
      );

      if (Board.isAnimationEnabled) {
        final controller = context.read<Board>().animationController[index];

        final animation = Tween<double>(
          begin: 1,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeOut,
          ),
        );
        final animatedBuilder = AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Transform(
            transform: Matrix4.diagonal3Values(1, 1, 1)
              ..rotateZ(1 - animation.value)
              ..scale(animation.value),
            alignment: FractionalOffset.center,
            child: Opacity(opacity: animation.value, child: child),
          ),
          child: item,
        );

        gridItems.add(
          Container(
            color: Colors.black,
            child: animatedBuilder,
          ),
        );
      } else {
        gridItems.add(item);
      }
    }
    return SizedBox.fromSize(
      size: gridSize,
      child: Center(
        child: Wrap(
          spacing: _divider,
          runSpacing: _divider,
          direction: Axis.horizontal,
          children: gridItems,
        ),
      ),
    );
  }

  double voodooTileDimension(BuildContext context) =>
      ([
        constraints.maxWidth,
        constraints.maxHeight,
      ].reduce(min) -
          2 * Theme.of(context).dividerTheme.thickness!) /
          (Board.y / Board.x) /
          Board.x -
          _divider;
}