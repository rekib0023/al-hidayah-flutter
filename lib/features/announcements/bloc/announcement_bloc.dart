import 'dart:async';

import 'package:al_hidayah/features/announcements/data_domain/announcement_repositories.dart';
import 'package:al_hidayah/models/notices.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository _announcementRepository =
      AnnouncementRepository();
  AnnouncementBloc() : super(AnnouncementInitial()) {
    on<AnnouncementInitialEvent>(announcementInitialEvent);
    on<AnnouncementViewButtonClickedEvent>(announcementViewButtonClickedEvent);
  }

  FutureOr<void> announcementInitialEvent(
      AnnouncementInitialEvent event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    NoticeList notices = await _announcementRepository.getNotices(
      limit: event.limit,
      offset: event.offset,
      title: event.title,
      showAll: event.showAll,
    );
    emit(AnnouncementsLoadedSuccess(notices));
  }

  FutureOr<void> announcementViewButtonClickedEvent(
      AnnouncementViewButtonClickedEvent event,
      Emitter<AnnouncementState> emit) {
    emit(AnnouncementViewButtonClick());
    emit(AnnouncementDetailState(event.notice));
  }
}
