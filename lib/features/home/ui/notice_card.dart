import 'package:al_hidayah/features/announcements/bloc/announcement_bloc.dart';
import 'package:al_hidayah/features/announcements/ui/announcement_detail.dart';
import 'package:al_hidayah/models/notices.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoticeCard extends StatefulWidget {
  const NoticeCard({super.key});

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  int _index = 0;

  final AnnouncementBloc _bloc = AnnouncementBloc();

  @override
  void initState() {
    _bloc.add(AnnouncementInitialEvent(limit: "5", showAll: "false"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementBloc, AnnouncementState>(
      bloc: _bloc,
      listenWhen: (previous, current) => current is AnnouncementActionState,
      buildWhen: (previous, current) => current is! AnnouncementActionState,
      listener: ((context, state) {
        if (state is AnnouncementViewButtonClick) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AnnouncementDetail(bloc: _bloc),
          ));
        }
      }),
      builder: (context, state) {
        switch (state.runtimeType) {
          case AnnouncementsLoadedSuccess:
            final successStae = state as AnnouncementsLoadedSuccess;
            NoticeList noticeList = successStae.notices;
            return GestureDetector(
              onTap: () {
                _bloc.add(AnnouncementViewButtonClickedEvent(
                    noticeList.notices[_index]));
              },
              child: SizedBox(
                height: 160,
                child: PageView.builder(
                  itemCount: noticeList.notices.length,
                  controller: PageController(viewportFraction: 0.8),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == _index ? 1 : 0.9,
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
                              Text(noticeList.notices[i].title,
                                  style: AppTextStyles.text.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 10),
                              Text(
                                noticeList.notices[i].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
