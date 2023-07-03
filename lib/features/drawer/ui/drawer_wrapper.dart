import 'package:al_hidayah/features/announcements/ui/announcements.dart';
import 'package:al_hidayah/features/drawer/bloc/drawer_bloc.dart';
import 'package:al_hidayah/features/home/ui/home.dart';
import 'package:al_hidayah/features/login/bloc/login_bloc.dart';
import 'package:al_hidayah/features/login/ui/login_screen.dart';
import 'package:al_hidayah/features/overview/ui/employee_overview/employee_overview.dart';
import 'package:al_hidayah/features/overview/ui/student_overview/student_overview.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../styles/colors.dart';
import 'drawer.dart';

class DrawerWrapper extends StatefulWidget {
  const DrawerWrapper({super.key, required this.authBloc});
  final AuthBloc authBloc;

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> {
  final DrawerBloc _bloc = DrawerBloc();

  String? authToken = "";

  @override
  void initState() {
    super.initState();
    getTokenAndInitialize();
  }

  void getTokenAndInitialize() async {
    authToken = await Store.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: widget.authBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! AuthLoadedSucessState) {
          return const LoginScreen();
        } else {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: AppColors.primary,
              title: Text(
                "Al-Hidayah",
                style: AppTextStyles.title.copyWith(color: Colors.white),
              ),
              centerTitle: true,
            ),
            drawer: DrawerMenu(
              bloc: _bloc,
              authBloc: widget.authBloc,
            ),
            body: BlocBuilder<DrawerBloc, DrawerState>(
              bloc: _bloc,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case DrawerStudentOverivewButtonClickActionState:
                    return const StudentOverview();
                  case DrawerEmployeeOverivewButtonClickActionState:
                    return const EmployeeOverview();
                  case DrawerManagementOverivewButtonClickActionState:
                    return const HomeScreen();
                  case DrawerAnnouncementsButtonClickActionState:
                    return const Announcements();
                  case DrawerHomeButtonClickActionState:
                    return const HomeScreen();
                  default:
                    return const HomeScreen();
                }
              },
            ),
          );
        }
      },
    );
  }
}
