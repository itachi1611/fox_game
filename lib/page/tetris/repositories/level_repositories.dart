import 'package:flutter_temp/page/tetris/repositories/game_repositories.dart';

import '../common/app_constants.dart';

abstract class LevelRepositories {
  int _current;

  int get current => _current;

  LevelRepositories(this._current);

  increaseLevel(GameRepositories game);
}

class LevelRepositoriesImpl extends LevelRepositories {
  LevelRepositoriesImpl({int? level}) : super(level ?? 0);

  @override
  void increaseLevel(GameRepositories game) {
    if (((_current + 1) * AppConstant.linesLevelStep) <= game.burnedLines) {
      _current += 1;
    }
  }
}