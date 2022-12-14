class MPiece {
  final Vector center;
  final Color color;
  final List<Vector> tiles = [];
  final Map<String, List<Vector>> offsets;

  Rotation rotation = Rotation.zero;

  Piece({
    required this.color,
    required this.offsets,
    required this.center,
    required List<List<int>> tiles,
  }) {
    tiles = tiles.reversed.toList();
    for (var yp = 0; yp < tiles.length; yp++) {
      for (var xp = 0; xp < tiles.first.length; xp++) {
        if (tiles[yp][xp] == 1) {
          this.tiles.add(Vector(xp, yp));
        }
      }
    }
  }

  Piece.empty()
      : center = Vector.zero,
        color = const Color(0xFF000000),
        offsets = {};

  void rotate({bool clockwise = true}) {
    final angle = clockwise ? -pi / 2 : pi / 2;
    for (var i = 0; i < tiles.length; i++) {
      final p = tiles[i];
      final px = cos(angle) * (p.x - center.x) -
          sin(angle) * (p.y - center.y) +
          center.x;
      final py = sin(angle) * (p.x - center.x) +
          cos(angle) * (p.y - center.y) +
          center.y;
      tiles[i] = Vector(px.round(), py.round());
    }
    rotation = _nextRotation(rotation, clockwise);
  }

  Vector spawnOffset(int w, int h) => Vector(
    --w ~/ 2 - tiles.map((e) => e.x).reduce(max) ~/ 2,
    --h - tiles.map((e) => e.y).reduce(max),
  );

  List<Vector> getKicks({required Rotation from, bool clockwise = true}) {
    final fromOffsets = offsets['$from'];
    final toOffsets = offsets['${_nextRotation(from, clockwise)}'];
    final result = <Vector>[];
    for (var index = 0; index < fromOffsets!.length + 1; index++) {
      final fromOffset = fromOffsets[index % fromOffsets.length];
      final toOffset = toOffsets![index % toOffsets.length];
      if (clockwise || fromOffsets.length == 1) {
        // o piece
        result.add(fromOffset - toOffset);
      } else {
        result.add(toOffset - fromOffset);
      }
    }
    return result;
  }

  Rotation _nextRotation(Rotation rotation, bool clockwise) => Rotation
      .values[(rotation.index + (clockwise ? 1 : -1)) % Rotation.values.length];

  int get width => tiles.reduce((a, b) => a.x > b.x ? a : b).x + 1;

  int get height => tiles.reduce((a, b) => a.y > b.y ? a : b).y + 1;
}