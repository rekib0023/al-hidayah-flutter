import 'package:al_hidayah/features/home/bloc/home_bloc.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  HomeGrid({super.key, required this.bloc});

  final HomeBloc bloc;

  final widgetList = [
    {
      "title": "Store",
      "icon": Icons.store,
      "color": const Color(0xAA068DA9),
    },
    {
      "title": "Expenses",
      "icon": Icons.account_balance_wallet,
      "color": const Color(0xAAB31312),
    },
    {
      "title": "Calendar",
      "icon": Icons.calendar_month,
      "color": const Color(0xAAFF6E31),
    },
    {
      "title": "Pre-Admission",
      "icon": Icons.supervised_user_circle,
      "color": const Color(0xAA090580),
    },
    {
      "title": "Audits",
      "icon": Icons.newspaper,
      "color": const Color(0xAA116D6E),
    },
    {
      "title": "Remarks",
      "icon": Icons.feedback,
      "color": const Color(0xAA5F264A),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      itemCount: widgetList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GridCard(
          element: widgetList[index],
          bloc: bloc,
        );
      },
    );
  }
}

class GridCard extends StatelessWidget {
  const GridCard({super.key, required this.element, required this.bloc});

  final Map<String, dynamic> element;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc.add(HomeGridButtonClickEvent(element["title"]));
      },
      child: Card(
        color: Colors.white,
        shape: Border(
          bottom: BorderSide(
            color: element['color'],
            width: 4,
          ),
        ),
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              element['icon'],
              size: 48,
              color: element["color"],
            ),
            const SizedBox(height: 10),
            Text(
              element['title'],
              style: AppTextStyles.text,
            ),
          ],
        ),
      ),
    );
  }
}
