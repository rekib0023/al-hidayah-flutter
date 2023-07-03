import 'package:al_hidayah/features/about_us/ui/about_us.dart';
import 'package:al_hidayah/features/announcements/ui/announcements.dart';
import 'package:al_hidayah/features/drawer/bloc/drawer_bloc.dart';
import 'package:al_hidayah/features/login/bloc/login_bloc.dart';
import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.bloc,
    required this.authBloc,
  });

  final DrawerBloc bloc;
  final AuthBloc authBloc;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset('assets/images/logo.jpeg'),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Al-Hidayah\n",
                        style:
                            AppTextStyles.heading.copyWith(color: Colors.white),
                        children: const [
                          TextSpan(
                            text: "International Public School",
                            style: AppTextStyles.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () {
                  bloc.add(
                    DrawerMenuItemClickedEvent(itemName: "home"),
                  );
                  Navigator.of(context).pop();
                },
              ),
              ExpansionTile(
                leading: const Icon(Icons.dashboard_outlined),
                title: const Text('Overview'),
                childrenPadding: const EdgeInsets.only(left: 16),
                children: [
                  ListTile(
                    leading: const Icon(Icons.school_outlined),
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
                    leading: const Icon(Icons.supervisor_account_outlined),
                    title: const Text('Employee'),
                    onTap: () {
                      bloc.add(
                        DrawerMenuItemClickedEvent(
                            itemName: "employee-overview"),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.admin_panel_settings_outlined),
                    title: const Text('Management'),
                    onTap: () {
                      bloc.add(
                        DrawerMenuItemClickedEvent(
                            itemName: "management-overview"),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.campaign),
                title: const Text("Announcements"),
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Announcements(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("About us"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutUs(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Logout"),
                onTap: () {
                  authBloc.add(AuthLogoutButtonClickedEvent());
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
