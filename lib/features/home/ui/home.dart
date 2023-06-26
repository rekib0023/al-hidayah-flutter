import 'package:al_hidayah/features/home/bloc/home_bloc.dart';
import 'package:al_hidayah/features/login/bloc/login_bloc.dart';
import 'package:al_hidayah/features/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Al-Hidayah"),
      ),
      body: Scaffold(
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: _homeBloc,
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case HomeInitial:
                return const Center(
                  child: Text("home"),
                );
              case AuthLoadedSucessState:
                return const Center(
                  child: Text("auth"),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
