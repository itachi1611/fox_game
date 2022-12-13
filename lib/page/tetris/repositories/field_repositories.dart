import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_temp/page/tetris/repositories/block_repositories.dart';

abstract class FieldRepositories {
  final int xSize;
  final int ySize;
  final Color colorBackGroundBlock;
  Map<int, BlockRepositoriesImpl> blocks = {};

  FieldRepositories(this.xSize, this.ySize, this.colorBackGroundBlock);

  mergeShapeToStack(List<BlockRepositories> blocks);

  removeLinesFromStack(SplayTreeMap<int, List<BlockRepositoriesImpl>> lineForRemoving);

  SplayTreeMap<int, List<BlockRepositoriesImpl>> detectBurningLines();
}

class FieldRepositoriesImpl extends FieldRepositories {
  FieldRepositoriesImpl({
    int? xSize,
    int? ySize,
    Color? colorBackGroundBlock,
  }) : super(
    xSize ?? 10,
    ySize ?? 20,
    colorBackGroundBlock ?? Colors.grey,
  );

  @override
  SplayTreeMap<int, List<BlockRepositoriesImpl>> detectBurningLines() {
    var blocksInLine = SplayTreeMap<int, List<BlockRepositoriesImpl>>();

    blocks.forEach((coordinate, block) {
      final int line = (coordinate / xSize).floor();
      if (blocksInLine.containsKey(line)) {
        blocksInLine[line]!.add(block);
      } else {
        blocksInLine.addAll({
          line: [block]
        });
      }
    });

    blocksInLine.removeWhere((key, value) => value.length < xSize);

    return blocksInLine;
  }

  @override
  mergeShapeToStack(List<BlockRepositories> blocks) {
    for (var block in blocks) {
      this.blocks[block.coordinate] = block;
    }
  }

  @override
  removeLinesFromStack(SplayTreeMap<int, List<BlockRepositoriesImpl>> lineForRemoving) {
    lineForRemoving.forEach((line, blockList) {
      for (final b in blockList) {
        // remove line
        blocks.remove(b.coordinate);
      }
    });

    // move other blocks down
    lineForRemoving.forEach((line, blockList) {
      Map<int, BlockRepositoriesImpl> resBlocks = {};
      blocks.forEach((coordinate, block) {
        if (coordinate < line * xSize) {
          var restBlock = block;
          restBlock.coordinate += xSize;
          resBlocks.addAll({coordinate + xSize: restBlock});
        } else {
          var restBlock = block;
          resBlocks.addAll({coordinate: restBlock});
        }
      });
      blocks = resBlocks;
    });

    return null;
  }
}