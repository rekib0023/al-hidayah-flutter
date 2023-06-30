import 'package:al_hidayah/features/announcements/bloc/announcement_bloc.dart';
import 'package:al_hidayah/features/announcements/ui/announcement_detail.dart';
import 'package:al_hidayah/models/notices.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final AnnouncementBloc bloc = AnnouncementBloc();
  @override
  void initState() {
    bloc.add(AnnouncementInitialEvent(showAll: "true"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Announcements"),
      body: BlocConsumer<AnnouncementBloc, AnnouncementState>(
        bloc: bloc,
        listenWhen: (previous, current) => current is AnnouncementActionState,
        buildWhen: (previous, current) => current is! AnnouncementActionState,
        listener: ((context, state) {
          if (state is AnnouncementViewButtonClick) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AnnouncementDetail(bloc: bloc),
            ));
          }
        }),
        builder: (context, state) {
          switch (state.runtimeType) {
            case AnnouncementsLoadedSuccess:
              final successState = state as AnnouncementsLoadedSuccess;
              final NoticeList noticeList = successState.notices;
              return ListView.builder(
                itemCount: noticeList.notices.length,
                itemBuilder: (context, index) {
                  final notice = noticeList.notices[index];
                  return GestureDetector(
                    onTap: () {
                      bloc.add(AnnouncementViewButtonClickedEvent(
                          noticeList.notices[index]));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice.title,
                              style: AppTextStyles.text.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(notice.description),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
