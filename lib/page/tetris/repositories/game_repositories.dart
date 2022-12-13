import 'dart:math';

import 'package:flutter_temp/page/tetris/repositories/field_repositories.dart';
import 'package:flutter_temp/page/tetris/repositories/level_repositories.dart';
import 'package:flutter_temp/page/tetris/repositories/score_repositories.dart';
import 'package:flutter_temp/page/tetris/repositories/shape_creator_repositories.dart';
import 'package:flutter_temp/page/tetris/repositories/shape_repositories.dart';
import 'package:flutter_temp/page/tetris/repositories/speed_repositories.dart';

typedef SetTimer = void Function(int milliseconds);

abstract class GameRepositories {
  final FieldRepositories playField;
  final LevelRepositories level;
  final SpeedRepositories speed;
  final ScoreRepositories score;
  final ShapeCreatorRepositories shapeCreator;

  ShapeRepositories? playingShape;
  bool needCheckCollision = false;
  int _burnedLines = 0;
  SetTimer? setTimer;
  Function? stopTimer;

  GameRepositories({
    required this.playField,
    required this.level,
    required this.speed,
    required this.score,
    required this.shapeCreator,
  });

  void step();

  void createShape();

  get burnedLines => _burnedLines;
}

class GameRepositoriesImpl extends GameRepositories {
  GameRepositoriesImpl({
    required FieldRepositories playField,
    required LevelRepositories level,
    required SpeedRepositories speed,
    required ScoreRepositories score,
    required ShapeCreatorRepositories shapeCreator,
  }) : super(playField: playField, level: level, speed: speed, score: score, shapeCreator: shapeCreator);

  @override
  void step() {
    if (playingShape == null) {
      createShape();
    } else {
      if (needCheckCollision) {
        _collisionHandle();
        needCheckCollision = false;
      } else {
        playingShape!.moveDown(playField);
        needCheckCollision = true;
      }
    }

    if (_isGameOver()) {
      stopTimer!();
    }
  }

  void _collisionHandle() {
    if (playingShape!.detectStackCollision(playField)) {
      playField.mergeShapeToStack(playingShape!.blocks);
      playingShape = null;

      var burnedLines = playField.detectBurningLines();

      if (burnedLines.isNotEmpty) {
        playField.removeLinesFromStack(burnedLines);
        score.setScore(burnedLines.length, level.current);
        _burnedLines += burnedLines.length;
        level.increaseLevel(this);
        setTimer!(speed.getMillisecond(level));
      }
    }
  }

  @override
  void createShape() {
    playingShape = shapeCreator.create(playField);
  }

  bool _isGameOver() => (playField.blocks.keys.fold(1000000, min) / playField.xSize).floor() == 0;
}
