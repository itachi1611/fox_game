import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/page/game/game_page.dart';
import 'package:flutter_temp/page/trending/trending_page.dart';
import 'package:flutter_temp/utils/app_connection.dart';
import 'package:flutter_temp/utils/app_flush_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app_cubit.dart';
import '../../utils/app_permission.dart';
import '../setting/setting_page.dart';
import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppCubit _appCubit;
  late final HomeCubit _homeCubit;
  late final AppPermission appPermission;
  late final PageController _pageController;

  Map _source = {ConnectivityResult.none: false};
  final AppConnection _networkConnectivity = AppConnection.instance;

  @override
  void initState() {
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context);
    _homeCubit = HomeCubit();
    _pageController = PageController();
    _networkConnectivity.initialise();

    _networkConnectivity.myStream.listen((source) {
      _source = source;
      appLogger.i('source $_source');
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.mobileOnline
              : ConnectionStatus.mobileOffline);
          break;
        case ConnectivityResult.wifi:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.wifiOnline
              : ConnectionStatus.wifiOffline);
          break;
        case ConnectivityResult.none:
        default:
          _appCubit.setConnectionStatus(ConnectionStatus.offline);
          break;
      }
    });

    appPermission = AppPermission(
        permission: Permission.camera,
        actionGranted: onGranted,
        actionDenied: onDenied);
    onCheckPermission();
  }

  void onCheckPermission() async =>
      await appPermission.onHandlePermissionStatus();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AppCubit, AppState>(
        bloc: _appCubit,
        listener: (context, state) {
          switch (state.connectionStatus) {
            case ConnectionStatus.mobileOffline:
            case ConnectionStatus.wifiOffline:
            case ConnectionStatus.offline:
              AppFlushBar.showFlushBar(context,
                  message: state.connectionStatus?.message.toString().trim(),
                  type: FlushType.error);
              break;
            case ConnectionStatus.mobileOnline:
            case ConnectionStatus.wifiOnline:
            default:
              AppFlushBar.showFlushBar(context,
                  message: state.connectionStatus?.message.toString().trim(),
                  type: FlushType.success);
              break;
          }
        },
        listenWhen: (pre, cur) => pre.connectionStatus != cur.connectionStatus,
        child: BlocConsumer<HomeCubit, HomeState>(
          bloc: _homeCubit,
          listener: (context, state) {
            _pageController.animateToPage(state.currentIndex!, duration: const Duration(milliseconds: 150), curve: Curves.fastLinearToSlowEaseIn);
          },
          listenWhen: (pre, cur) => pre.currentIndex != cur.currentIndex,
          buildWhen: (pre, cur) => pre.currentIndex != cur.currentIndex,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: PageView(
                controller: _pageController,
                children: const [
                  GamePage(),
                  TrendingPage(),
                  SettingPage(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.videogame_asset_rounded),
                    activeIcon: Icon(Icons.videogame_asset_rounded),
                    label: 'Game',
                    backgroundColor: Colors.lightBlue,
                    tooltip: 'Game',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper_rounded),
                    activeIcon: Icon(Icons.newspaper_rounded),
                    label: 'Trending',
                    backgroundColor: Colors.lightBlue,
                    tooltip: 'Trending',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_rounded),
                    activeIcon: Icon(Icons.settings_rounded),
                    label: 'Setting',
                    backgroundColor: Colors.lightBlue,
                    tooltip: 'Setting',
                  ),
                ],
                currentIndex: state.currentIndex ?? 0,
                onTap: (index) => _homeCubit.onChangeBottomNavBarIndex(index),
                elevation: 10,
                type: BottomNavigationBarType.shifting,
                backgroundColor: Colors.red, // not using when type is shifting
                iconSize: 24,
                //fixedColor: Colors.red,
                selectedItemColor: Colors.pink,
                unselectedItemColor: Colors.green,
                selectedFontSize: 13,
                unselectedFontSize: 13,
                selectedLabelStyle: GoogleFonts.sourceCodePro(),
                unselectedLabelStyle: GoogleFonts.sourceCodePro(),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                enableFeedback: true,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              ),
            );
          },
        ),
      ),
    );
  }

  void onGranted() => appLogger.i('granted');
  void onDenied() => appLogger.i('denied');

  @override
  void dispose() {
    _pageController.dispose();
    _networkConnectivity.disposeStream();
    appPermission.dispose();
    _appCubit.close();
    super.dispose();
  }
}
