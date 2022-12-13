import 'package:flutter_temp/page/tetris/repositories/field_repositories.dart';

import 'block_repositories.dart';
import 'shape_orientation_repositories.dart';

class TurnException implements Exception {}

abstract class ShapeRepositories {
  //Color color;
  List<BlockRepositories> blocks;
  final ShapeOrientationRepositories _orientation = ShapeOrientationRepositoriesImpl();

  ShapeRepositories(this.blocks);

  // counterClockwise();

  clockwise(FieldRepositories playField);

  // List<BlockRepositories> coordinatesBlocks();

  get orientation => _orientation;

  bool detectStackCollision(FieldRepositories playField) {
    var isCollision = false;

    for (final b in blocks) {
      if (b.coordinate + playField.xSize >= playField.xSize * playField.ySize) {
        // reach the bottom
        isCollision = true;
        break;
      } else if (playField.blocks != null &&
          playField.blocks.containsKey(b.coordinate + playField.xSize)) {
        // reach another shape
        isCollision = true;
      }
    }

    return isCollision;
  }

  bool detectLeftCollision(FieldRepositories playField) {
    bool isCollision = false;
    for (final b in blocks) {
      if ((b.coordinate) % playField.xSize == 0) {
        //reach lift boundary
        isCollision = true;
        break;
      } else if (playField.blocks.containsKey(b.coordinate - 1)) {
        // reach another shape on the left
        isCollision = true;
        break;
      }
    }
    return isCollision;
  }

  bool detectRightCollision(FieldRepositories playField) {
    bool isCollision = false;
    for (final b in blocks) {
      if ((b.coordinate + 1) % playField.xSize == 0) {
        // reach right boundary
        isCollision = true;
        break;
      } else if (playField.blocks.containsKey(b.coordinate + 1)) {
        // reach another shape on the right
        isCollision = true;
        break;
      }
    }

    return isCollision;
  }

  // bool outOfBounds(FieldRepositories playField) {
  //   bool isOutOfBounds = false;
  //  for (b in blocks) {
  //    if () {}
  //  }
  // }

  moveDown(FieldRepositories playField) {
    if (!detectStackCollision(playField)) {
      for (var b in blocks) {
        b.coordinate += playField.xSize;
      }
    }
  }

  moveRight(FieldRepositories playField, {int? blockCount}) {
    if (!detectRightCollision(playField)) {
      for (var b in blocks) {
        b.coordinate += blockCount ?? 1;
      }
    }
  }

  moveLeft(FieldRepositories playField, {int? blockCount}) {
    if (!detectLeftCollision(playField)) {
      for (var b in blocks) {
        b.coordinate -= blockCount ?? 1;
      }
    }
  }

  bool canRotateNearBoundLeft(int numberBlocksNeedToRotate, FieldRepositories playField) {
    bool canRotate = true;
    for (var b in blocks) {
      final int firstCoordinateInLine = (b.coordinate / playField.xSize).floor() * playField.xSize;
      if (numberBlocksNeedToRotate > (b.coordinate - firstCoordinateInLine)) {
        canRotate = false;
      }
    }

    return canRotate;
  }

  bool canRotateNearBoundRight(int numberBlocksNeedToRotate, FieldRepositories playField) {
    bool canRotate = true;
    for (var b in blocks) {
      final int lastCoordinateInLine =
          (b.coordinate / playField.xSize).floor() * playField.xSize +
              playField.xSize -
              1;
      if (numberBlocksNeedToRotate > (lastCoordinateInLine - b.coordinate)) {
        canRotate = false;
      }
    }

    return canRotate;
  }
}
