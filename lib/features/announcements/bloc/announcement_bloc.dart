import 'dart:async';

import 'package:al_hidayah/features/announcements/data_domain/announcement_repositories.dart';
import 'package:al_hidayah/features/announcements/data_domain/notices.dart';
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
    on<AnnouncementEventSearchButtonClickedEvent>(
        announcementEventSearchButtonClickedEvent);
    on<AnnoucementDeleteButtonClickedEvent>(
        annoucementDeleteButtonClickedEvent);
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

  FutureOr<void> announcementEventSearchButtonClickedEvent(
      AnnouncementEventSearchButtonClickedEvent event,
      Emitter<AnnouncementState> emit) {
    String search = event.search;
    List<Notice> allNotices = event.notices;
    List<Notice> filteredNotices = allNotices.where((notice) {
      final lowerCaseSearch = search.toLowerCase();
      final lowerCaseTitle = notice.title.toLowerCase();
      final lowerCaseDescription = notice.description.toLowerCase();

      return lowerCaseTitle.contains(lowerCaseSearch) ||
          lowerCaseDescription.contains(lowerCaseSearch);
    }).toList();
    emit(AnnouncementFilteredNotices(filteredNotices));
  }

  FutureOr<void> annoucementDeleteButtonClickedEvent(
      AnnoucementDeleteButtonClickedEvent event,
      Emitter<AnnouncementState> emit) async {
    await _announcementRepository.deleteNotice(event.id);
    emit(AnnoucementDeleteState());
  }
}
