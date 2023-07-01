part of 'announcement_bloc.dart';

@immutable
abstract class AnnouncementState {}

abstract class AnnouncementActionState extends AnnouncementState {}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementsLoadedSuccess extends AnnouncementState {
  final NoticeList notices;

  AnnouncementsLoadedSuccess(this.notices);
}

class AnnouncementViewButtonClick extends AnnouncementActionState {}

class AnnouncementDetailState extends AnnouncementActionState {
  final Notice notice;

  AnnouncementDetailState(this.notice);
}

class AnnouncementFilteredNotices extends AnnouncementState {
  final List<Notice> notices;

  AnnouncementFilteredNotices(this.notices);
}

class AnnoucementDeleteState extends AnnouncementActionState {}
