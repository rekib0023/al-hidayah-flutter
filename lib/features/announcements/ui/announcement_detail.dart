import 'package:al_hidayah/features/announcements/bloc/announcement_bloc.dart';
import 'package:al_hidayah/features/announcements/data_domain/notices.dart';
import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:al_hidayah/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementDetail extends StatelessWidget {
  const AnnouncementDetail({super.key, required this.bloc});

  final AnnouncementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: appBar(title: "Announcement"),
        body: SingleChildScrollView(
          child: BlocConsumer<AnnouncementBloc, AnnouncementState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is AnnoucementDeleteState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: AppColors.red,
                    content: Text("Notice deleted"),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case AnnouncementDetailState:
                  final successState = state as AnnouncementDetailState;
                  final Notice notice = successState.notice;
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notice.title,
                          style: AppTextStyles.title,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          notice.description,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                text: "Edit",
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: SecondaryButton(
                                text: "Delete",
                                onPressed: () {
                                  bloc.add(AnnoucementDeleteButtonClickedEvent(
                                      notice.id));
                                },
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
