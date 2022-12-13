abstract class ScoreRepositories {
  late num _current;

  num get current => _current;

  void setScore(int burnedLines, int level);
}

class ScoreRepositoriesImpl extends ScoreRepositories {
  Map<int, int> burnedLinesToBasePoints = {
    1: 40,
    2: 100,
    3: 300,
    4: 1200,
  };

  @override
  void setScore(int burnedLines, int level) {
    _current = (_current ?? 0) + burnedLinesToBasePoints[burnedLines]! * (level + 1);
  }
}