import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tetris_state.dart';

class TetrisCubit extends Cubit<TetrisState> {
  TetrisCubit() : super(const TetrisState());


  MLevel getLevel(int rows) => _level[_getLevelIndex(rows)];

  /// https://harddrop.com/wiki/Tetris_(Game_Boy)
  /// Random level
  const _levelFrameRate = [
    53,
    49,
    45,
    41,
    37,
    33,
    28,
    22,
    17,
    11,
    10,
    9,
    8,
    7,
    6,
    6,
    5,
    5,
    4,
    4,
    3,
  ];

  final _level = List.generate(
    _levelFrameRate.length,
        (index) => Level(
      index + 1,
      _levelFrameRate[index],
    ),
  );

  int _getLevelIndex(int rows) {
    var level = (rows - rows % 10) ~/ 10;
    if (level >= _level.length) {
      level = _level.length - 1;
    }
    return level;
  }

  /// https://harddrop.com/wiki/Random_Generator
  /// Random pieces
  List<Piece> get nextPieceBag => _tiles
      .mapIndexed((index, element) => Piece(
    center: _center[index],
    color: _colors[index],
    tiles: element,
    offsets: _offsets[index],
  ))
      .toList()
    ..shuffle(); // 7! permutations (5040)

  const _tiles = [
    [
      [1, 1, 1, 1]
    ],
    [
      [1, 1],
      [1, 1],
    ],
    [
      [0, 1, 0],
      [1, 1, 1],
    ],
    [
      [1, 0, 0],
      [1, 1, 1],
    ],
    [
      [0, 0, 1],
      [1, 1, 1],
    ],
    [
      [0, 1, 1],
      [1, 1, 0],
    ],
    [
      [1, 1, 0],
      [0, 1, 1],
    ],
  ];

  const _colors = [
    Colors.teal,
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
  ];

  const _center = [
    Vector(1, 0),
    Vector.zero,
    Vector(1, 0),
    Vector(1, 0),
    Vector(1, 0),
    Vector(1, 0),
    Vector(1, 0),
  ];

  /// https://tetris.wiki/Super_Rotation_System#How_Guideline_SRS_Really_Works
  const _offsets = [
    _iOffsetData,
    _oOffsetData,
    _jlstzOffsetData,
    _jlstzOffsetData,
    _jlstzOffsetData,
    _jlstzOffsetData,
    _jlstzOffsetData,
  ];

  const _jlstzOffsetData = {
    '0': [Vector.zero, Vector.zero, Vector.zero, Vector.zero, Vector.zero],
    'R': [Vector.zero, Vector(1, 0), Vector(1, -1), Vector(0, 2), Vector(1, 2)],
    '2': [Vector.zero, Vector.zero, Vector.zero, Vector.zero, Vector.zero],
    'L': [
      Vector.zero,
      Vector(-1, 0),
      Vector(-1, -1),
      Vector(0, 2),
      Vector(-1, 2)
    ],
  };

  const _iOffsetData = {
    '0': [Vector.zero, Vector(-1, 0), Vector(2, 0), Vector(-1, 0), Vector(2, 0)],
    'R': [Vector(-1, 0), Vector.zero, Vector.zero, Vector(0, 1), Vector(0, -2)],
    '2': [
      Vector(-1, 1),
      Vector(1, 1),
      Vector(-2, 1),
      Vector(1, 0),
      Vector(-2, 0)
    ],
    'L': [Vector(0, 1), Vector(0, 1), Vector(0, 1), Vector(0, -1), Vector(0, 2)],
  };

  const _oOffsetData = {
    '0': [Vector.zero],
    'R': [Vector(0, -1)],
    '2': [Vector(-1, -1)],
    'L': [Vector(-1, 0)],
  };
}
