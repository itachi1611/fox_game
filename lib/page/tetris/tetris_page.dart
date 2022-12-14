import 'package:flutter/material.dart';
import 'package:flutter_temp/page/tetris/widgets/center_widget.dart';
import 'package:flutter_temp/page/tetris/widgets/left_widget.dart';
import 'package:flutter_temp/page/tetris/widgets/touch_widget.dart';

import '../../models/tetris/m_board.dart';
import 'widgets/right_widget.dart';

class TetrisPage extends StatefulWidget {
  const TetrisPage({Key? key}) : super(key: key);

  @override
  State<TetrisPage> createState() => _TetrisPageState();
}

class _TetrisPageState extends State<TetrisPage> {
  @override
  Widget build(BuildContext context) {
    return TouchWidget(
      onTapUp: (details) => context.read<MBoard>().onTapUp(context, details),
      onTouch: context.read<MBoard>().onTouch,
      child: Focus(
        onKey: context.read<MBoard>().onKey,
        autofocus: true,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: LayoutBuilder(
                  builder: (context, constraints) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LeftWidget(),
                      CenterWidget(constraints: constraints)
                      const RightWidget(),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
