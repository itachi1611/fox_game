import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/database/app_shared_preference.dart';
import 'package:flutter_temp/page/2048/2048_cubit.dart';

mixin GridMixin on Cubit<TwoZeroFourEightState>{
  List<List<int>> blankGrid(){
    List<List<int>> rows = [];
    for(int i=0;i<4;i++){
      rows.add([0,0,0,0]);
    }
    return rows;
  }

  bool compare(List<List<int>> a,List<List<int>> b){
    for(int i=0;i<4;i++){
      for(int j=0;j<4;j++){
        if(a[i][j] != b[i][j]){
          return false;
        }
      }
    }
    return true;
  }

  List<List<int>> copyGrid(List<List<int>> grid){
    List<List<int>> extraGrid = blankGrid();
    for(int i=0;i<4;i++){
      for(int j=0;j<4;j++){
        extraGrid[i][j] = grid[i][j];
      }
    }
    return extraGrid;
  }

  List<List<int>> flipGrid(List<List<int>> grid){
    for(int i=0;i<4;i++){
      List<int> row = grid[i];
      grid[i]=row.reversed.toList();
    }
    return grid;
  }

  List<List<int>> transposeGrid(List<List<int>> grid){
    List<List<int>> newGrid = blankGrid();
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        newGrid[i][j] = grid[j][i];
      }
    }
    return newGrid;
  }

  List<List<int>> addNumber(List<List<int>> grid,List<List<int>> gridNew){
    List<Point> options = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) {
          options.add(Point(i, j));
        }
      }
    }
    if (options.isNotEmpty) {
      int spotRandomIndex = Random().nextInt(options.length);
      Point spot = options[spotRandomIndex];
      int r = Random().nextInt(100);
      grid[spot.x.toInt()][spot.y.toInt()] = r > 50 ? 4 : 2;
      gridNew[spot.x.toInt()][spot.y.toInt()] = 1;
    }

    return grid;
  }

  Future<List> operate(List<int> row,int score) async {
    row = slide(row);
    List result = await combine(row,score);
    int sc=result[0];
    row = result[1];
    row = slide(row);

    debugPrint('from func $sc');
    return [sc,row];
  }

  List<int> filter(List<int> row){
    List<int> temp = [];
    for(int i=0;i<row.length;i++){
      if(row[i] != 0){
        temp.add(row[i]);
      }
    }
    return temp;
  }

  List<int> slide(List<int> row){
    List<int> arr = filter(row);
    int missing = 4-arr.length;
    List<int> zeroes = zeroArray(missing);
    arr = zeroes + arr;
    return arr;
  }

  List<int> zeroArray(int length){
    List<int> zeroes = [];
    for(int i=0;i<length;i++){
      zeroes.add(0);
    }
    return zeroes;
  }


  Future<List> combine(List<int> row,int score) async {
    for (int i = 3; i >= 1; i--) {
      int a = row[i];
      int b = row[i - 1];
      if (a == b) {
        row[i] = a + b;
        score += row[i];
        int? sc = await AppSharedPreference.getHighScore();
        if(sc == null){
          AppSharedPreference.saveHighScore(score);
        }else {
          if(score > sc) {
            AppSharedPreference.saveHighScore(score);
          }
        }
        row[i - 1] = 0;

      }
    }
    return [score,row];
  }

  bool isGameWon(List<List<int>> grid) {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 2048) {
          return true;
        }
      }
    }
    return false;
  }


  bool isGameOver(List<List<int>> grid) {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) {
          return false;
        }
        if (i != 3 && grid[i][j] == grid[i + 1][j]) {
          return false;
        }
        if (j != 3 && grid[i][j] == grid[i][j + 1]) {
          return false;
        }
      }
    }
    return true;
  }
}