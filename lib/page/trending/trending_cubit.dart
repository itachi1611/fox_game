import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../models/hive_model/user.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit() : super(const TrendingState());

  Future<void> initData() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final userBox = await Hive.openBox('users');

    for(var i = 0; i < 10; i++) {
      var dump = User(id: const Uuid().v1(), name: 'Fox $i', age: i + 30);
      userBox.add(dump);
    }
    emit(state.copyWith(loadStatus: LoadStatus.success));
  }
}
