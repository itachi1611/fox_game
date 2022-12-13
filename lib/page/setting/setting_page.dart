import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/generated/l10n.dart';

import '../../app/app_cubit.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final AppCubit _appCubit;

  @override
  void initState() {
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context);
  }

  @override
  void dispose() {
    _appCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      bloc: _appCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Switch(
                inactiveThumbColor: Colors.green,
                inactiveTrackColor: Colors.pink[200],
                activeColor: Colors.blue,
                activeTrackColor: Colors.pink[200],
                value: state.themeMode == ThemeMode.light ? true : false,
                onChanged: (val) {
                  _appCubit.onChangeSwitch(val);
                },
              ),
              DropdownButton(
                items: ['Eng', 'Vie', 'Jap']
                    .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  _appCubit.setLocale(val);
                },
              ),
              Text(S.current.title),
            ],
          ),
        );
      },
    );
  }
}
