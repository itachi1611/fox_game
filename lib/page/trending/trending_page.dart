import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/page/trending/trending_cubit.dart';
import 'package:hive/hive.dart';

import '../../models/hive_model/user.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  late final TrendingCubit _trendingCubit;

  @override
  void initState() {
    super.initState();
    _trendingCubit = TrendingCubit();
    _trendingCubit.initData();
  }

  @override
  void dispose() {
    _trendingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingCubit, TrendingState>(
      bloc: _trendingCubit,
      buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
      builder: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          return _loading;
        } else if (state.loadStatus == LoadStatus.fail) {
          return _fail;
        } else {
          return _success();
        }
      },
    );
  }

  /// Widget components
  Widget get _loading => const CircularProgressIndicator().center;
  Widget get _fail => const Text('Error').center;
  Widget _success() {
    var userBox = Hive.box('users');
    return ListView.separated(
      itemBuilder: (context, index) {
        var user = userBox.getAt(index) as User;
        return Text('${user.id} - ${user.name} - ${user.age}');
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemCount: userBox.length,
    );
  }
}
