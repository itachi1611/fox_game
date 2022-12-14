import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/page/2048/2048_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';

class TwoZeroFourEightPage extends StatefulWidget {
  const TwoZeroFourEightPage({Key? key}) : super(key: key);

  @override
  State<TwoZeroFourEightPage> createState() => _TwoZeroFourEightPageState();
}

class _TwoZeroFourEightPageState extends State<TwoZeroFourEightPage> {
  late final TwoZeroFourEightCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = TwoZeroFourEightCubit();
    _cubit.initGame();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '2048',
          style: GoogleFonts.sourceCodePro(
              fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.gridBg,
      ),
      body: BlocBuilder<TwoZeroFourEightCubit, TwoZeroFourEightState>(
        bloc: _cubit,
        buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.loading) {
            return loading;
          } else if (state.loadStatus == LoadStatus.fail) {
            return fail;
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: AppColors.gridBg,
                    ),
                    height: 82.0,
                    child: Column(
                      children: [
                        const Text(
                          'Score',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ).paddingEach(t: 10.0, b: 2.0),
                        Text(
                          state.score.toString(),
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ).paddingEach(b: 10.0)
                      ],
                    ),
                  ).paddingAll(10),
                  Container(
                    height: state.height,
                    color: AppColors.gridBg,
                    child: Stack(
                      children: [
                        BlocBuilder<TwoZeroFourEightCubit, TwoZeroFourEightState>(
                          bloc: _cubit,
                          buildWhen: (pre, cur) => pre.grid != cur.grid,
                          builder: (context, state) {
                            var widget = _cubit.getGrid(state.gridWidth!, state.gridHeight!);
                            return GestureDetector(
                              child: GridView.count(
                                primary: false,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                crossAxisCount: 4,
                                children: widget,
                              ),
                              onVerticalDragEnd: (DragEndDetails details) {
                                //primaryVelocity -ve up +ve down
                                if (details.primaryVelocity! < 0) {
                                  _cubit.handleGesture(0);
                                } else if (details.primaryVelocity! > 0) {
                                  _cubit.handleGesture(1);
                                }
                              },
                              onHorizontalDragEnd: (details) {
                                //-ve right, +ve left
                                if (details.primaryVelocity! > 0) {
                                  _cubit.handleGesture(2);
                                } else if (details.primaryVelocity! < 0) {
                                  _cubit.handleGesture(3);
                                }
                              },
                            );
                          },
                        ).paddingAll(10),
                        if (state.isGameOver!) ...[
                          Container(
                            height: state.height,
                            color: AppColors.transparentWhite,
                            child: const Center(
                              child: Text(
                                'Game over!',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.gridBg,
                                ),
                              ),
                            ),
                          ),
                        ],
                        if (state.isGameWon!) ...[
                          Container(
                            height: state.height,
                            color: AppColors.transparentWhite,
                            child: const Center(
                              child: Text(
                                'You Won!',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.gridBg,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: AppColors.gridBg,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              iconSize: 35.0,
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                _cubit.initGame();
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: AppColors.gridBg,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: const [
                                Text(
                                  'High Score',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold),
                                ),
                                // FutureBuilder<String>(
                                //   future: getHighScore(),
                                //   builder: (ctx, snapshot) {
                                //     if (snapshot.hasData) {
                                //       return Text(
                                //         snapshot.data,
                                //         style: const TextStyle(
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.bold),
                                //       );
                                //     } else {
                                //       return const Text(
                                //         '0',
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.bold),
                                //       );
                                //     }
                                //   },
                                // )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).paddingAll(20.0),
            );
          }
        },
      ),
    );
  }

  /// Component widgets
  Widget get loading => const CircularProgressIndicator().center;

  Widget get fail => const Text('Something wrong....').center;
}
