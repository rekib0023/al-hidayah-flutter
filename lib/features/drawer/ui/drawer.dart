import 'package:al_hidayah/features/drawer/bloc/drawer_bloc.dart';
import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.bloc,
  });

  final DrawerBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerBloc, DrawerState>(
      bloc: bloc,
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Al-Hidayah\n",
                    style: AppTextStyles.heading.copyWith(color: Colors.white),
                    children: const [
                      TextSpan(
                        text: "International Public School",
                        style: AppTextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  bloc.add(
                    DrawerMenuItemClickedEvent(itemName: "home"),
                  );
                  Navigator.of(context).pop();
                },
              ),
              ExpansionTile(
                title: const Text('Overview'),
                childrenPadding: const EdgeInsets.only(left: 16),
                children: [
                  ListTile(
                    title: const Text('Student'),
                    onTap: () {
                      bloc.add(
                        DrawerMenuItemClickedEvent(
                            itemName: "student-overview"),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Management'),
                    onTap: () {
                      bloc.add(
                        DrawerMenuItemClickedEvent(
                            itemName: "management-overview"),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Employee'),
                    onTap: () {
                      bloc.add(
                        DrawerMenuItemClickedEvent(
                            itemName: "employee-overivew"),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
