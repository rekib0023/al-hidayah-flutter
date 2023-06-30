import 'package:al_hidayah/features/announcements/ui/announcements.dart';
import 'package:al_hidayah/features/home/bloc/home_bloc.dart';
import 'package:al_hidayah/features/home/ui/home_grid.dart';
import 'package:al_hidayah/features/home/ui/notice_card.dart';
import 'package:al_hidayah/styles/text_styles.dart';
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
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeInitial:
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Notices",
                            style: AppTextStyles.title,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Announcements(),
                              ));
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text("see more"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const NoticeCard(),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: HomeGrid(),
                    )
                  ],
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
