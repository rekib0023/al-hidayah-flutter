import 'package:al_hidayah/features/drawer/bloc/drawer_bloc.dart';
import 'package:al_hidayah/features/drawer/ui/drawer_wrapper.dart';
import 'package:al_hidayah/features/overview/bloc/overview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/bloc/login_bloc.dart';
import 'styles/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => OverviewBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        home: DrawerWrapper(
          authBloc: authBloc,
        ),
      ),
    );
  }
}
