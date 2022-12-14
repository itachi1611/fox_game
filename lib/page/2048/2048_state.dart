part of '2048_cubit.dart';

class TwoZeroFourEightState extends Equatable {
  const TwoZeroFourEightState({
    this.loadStatus,
    this.width,
    this.height,
    this.gridWidth,
    this.gridHeight,
    this.score,
    this.grid,
    this.gridNew,
    this.isGameOver,
    this.isGameWon,
  });

  final LoadStatus? loadStatus;
  final double? width;
  final double? height;
  final double? gridWidth;
  final double? gridHeight;
  final int? score;
  final List<List<int>>? grid;
  final List<List<int>>? gridNew;
  final bool? isGameOver;
  final bool? isGameWon;

  TwoZeroFourEightState copyWith({
    LoadStatus? loadStatus,
    double? width,
    double? height,
    double? gridWidth,
    double? gridHeight,
    int? score,
    List<List<int>>? grid,
    List<List<int>>? gridNew,
    bool? isGameOver,
    bool? isGameWon,
  }) {
    return TwoZeroFourEightState(
      loadStatus: loadStatus ?? this.loadStatus,
      width: width ?? this.width,
      height: height ?? this.height,
      gridWidth: gridWidth ?? this.gridWidth,
      gridHeight: gridHeight ?? this.gridHeight,
      score: score ?? this.score,
      grid: grid ?? this.grid,
      gridNew: gridNew ?? this.gridNew,
      isGameOver: isGameOver ?? this.isGameOver,
      isGameWon: isGameWon ?? this.isGameWon,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        width,
        height,
        gridWidth,
        gridHeight,
        score,
        grid,
        gridNew,
        isGameOver,
        isGameWon
      ];
}
