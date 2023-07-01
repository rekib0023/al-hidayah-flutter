part of 'announcement_bloc.dart';

@immutable
abstract class AnnouncementEvent {}

class AnnouncementInitialEvent extends AnnouncementEvent {
  final String limit, offset, title, showAll;

  AnnouncementInitialEvent({
    this.limit = "",
    this.offset = "",
    this.title = "",
    this.showAll = "",
  });
}

class AnnouncementViewButtonClickedEvent extends AnnouncementEvent {
  final Notice notice;

  AnnouncementViewButtonClickedEvent(this.notice);
}

class AnnouncementEventSearchButtonClickedEvent extends AnnouncementEvent {
  final String search;
  final List<Notice> notices;

  AnnouncementEventSearchButtonClickedEvent(this.search, this.notices);
}

class AnnoucementDeleteButtonClickedEvent extends AnnouncementEvent {
  final String id;

  AnnoucementDeleteButtonClickedEvent(this.id);
}
