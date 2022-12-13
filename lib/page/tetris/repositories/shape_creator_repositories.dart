import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_temp/page/tetris/repositories/field_repositories.dart';
import 'package:flutter_temp/page/tetris/repositories/shape_repositories.dart';

abstract class ShapeCreatorRepositories {
  ShapeRepositories create(FieldRepositories playField);
}

class ShapeCreatorRepositoriesImpl implements ShapeCreatorRepositories {
  @override
  ShapeRepositories create(FieldRepositories playField) {
    Random random = Random();
    var color = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );

    ShapeRepositories shape;
    switch (random.nextInt(7)) {
    // 7 to generate random 0 - 6
      case 0:
        shape = SShape(playField, color);
        shape.moveRight(playField, blockCount: (playField.xSize / 2).floor() - 1 );
        break;
      case 1:
        shape = OShape(playField,  color);
        shape.moveRight(playField, blockCount: (playField.xSize / 2).floor() - 1);
        break;
      case 2:
        shape = LShape(playField, color);
        shape.moveRight(playField, blockCount: (playField.xSize / 2).floor() - 1 );
        break;
      case 3:
        shape = IShape(playField, color);
        shape.moveRight(
            playField, blockCount: (playField.xSize / 2).floor() - 2);
        break;
      case 4:
        shape = TShape(playField, color);
        shape.moveRight(playField, blockCount: (playField.xSize / 2).floor() - 1);
        break;
      case 5:
        shape = ZShape(playField, color);
        shape.moveRight(playField, blockCount: (playField.xSize / 2).floor() - 1 );
        break;
      case 6:
        shape = JShape(playField, color);
        shape.moveRight(playField, blockCount: (playField.xSize / 2).floor() - 1 );
        break;
    }

    return shape;
  }
}