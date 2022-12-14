import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/common/app_colors.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/database/app_shared_preference.dart';
import 'package:flutter_temp/page/2048/widgets/tile_widget.dart';
import 'package:flutter_temp/utils/2048/grid_mixin.dart';

part '2048_state.dart';

class TwoZeroFourEightCubit extends Cubit<TwoZeroFourEightState>
    with GridMixin {
  TwoZeroFourEightCubit() : super(const TwoZeroFourEightState());

  void initGame() {
    emit(state.copyWith(loadStatus: LoadStatus.loading));

    var width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    var gridWidth = (width - 80) / 4;
    var gridHeight = gridWidth;
    var height = 30 + (gridHeight * 4) + 10;

    var grid = blankGrid();
    var gridNew = blankGrid();
    addNumber(grid, gridNew);
    addNumber(grid, gridNew);

    emit(state.copyWith(
      loadStatus: LoadStatus.success,
      width: width,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      height: height,
      grid: grid,
      gridNew: gridNew,
      isGameOver: false,
      isGameWon: false,
      score: 0,
    ));
  }

  List<Widget> getGrid(double width, double height) {
    List<Widget> grids = [];
    var currentGrid = state.grid ?? [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        int num = currentGrid[i][j];
        String number;
        Color color;
        if (num == 0) {
          color = AppColors.emptyGridBg;
          number = '';
        } else if (num == 2 || num == 4) {
          color = AppColors.gridColor24;
          number = '$num';
        } else if (num == 8 || num == 64 || num == 256) {
          color = AppColors.gridColor864256;
          number = '$num';
        } else if (num == 16 || num == 32 || num == 1024) {
          color = AppColors.gridColor16321024;
          number = '$num';
        } else if (num == 128 || num == 512) {
          color = AppColors.gridColor128512;
          number = '$num';
        } else {
          color = AppColors.gridColorWin;
          number = '$num';
        }

        double? size;
        String n = number;
        switch (n.length) {
          // Define button width with providing digits (1, 2, 3 or 4)
          case 1:
          case 2:
            size = 40.0;
            break;
          case 3:
            size = 30.0;
            break;
          case 4:
            size = 20.0;
            break;
        }
        grids.add(TileWidget(
            number: number,
            width: width,
            height: height,
            color: color,
            size: size));
      }
    }
    return grids;
  }

  Future<void> handleGesture(int direction) async {
    /*
      0 = up
      1 = down
      2 = left
      3 = right
    */

    bool flipped = false;
    bool played = true;
    bool rotated = false;

    var grid = List.of(state.grid!.map((e) => e = List.of(e)));
    var score = 0;

    if (direction == 0) {
      grid = transposeGrid(grid);
      grid = flipGrid(grid);
      rotated = true;
      flipped = true;
    } else if (direction == 1) {
      grid = transposeGrid(grid);
      rotated = true;
    } else if (direction == 2) {
    } else if (direction == 3) {
      grid = flipGrid(grid);
      flipped = true;
    } else {
      played = false;
    }

    emit(state.copyWith(grid: grid));

    if (played) {
      debugPrint('playing');
      List<List<int>> past = copyGrid(grid);
      debugPrint('past $past');
      for (int i = 0; i < 4; i++) {
        List result = await operate(grid[i], state.score!);
        score = result[0];
        debugPrint('score in set state $score');
        grid[i] = result[1];
      }
      grid = addNumber(grid, state.gridNew!);

      bool changed = compare(past, grid);
      debugPrint('changed $changed');
      if (flipped) {
        grid = flipGrid(grid);
      }

      if (rotated) {
        grid = transposeGrid(grid);
      }

      if (changed) {
        grid = addNumber(grid, state.gridNew!);
        debugPrint('is changed');
      } else {
        debugPrint('not changed');
      }

      emit(state.copyWith(grid: grid));

      bool isOver = isGameOver(grid);
      if (isOver) {
        debugPrint('game over');
        emit(state.copyWith(isGameOver: true));
      }

      bool isWon = isGameWon(grid);
      if (isWon) {
        debugPrint("GAME WON");
        emit(state.copyWith(isGameWon: true));
      }
      debugPrint(grid.toString());
      debugPrint(state.score.toString());
    }
  }
}
