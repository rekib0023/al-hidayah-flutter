class NoticeList {
  NoticeList({
    required this.totalNotices,
    required this.notices,
  });
  late final int totalNotices;
  late final List<Notice> notices;

  NoticeList.fromJson(Map<String, dynamic> json) {
    totalNotices = json['totalNotices'];
    notices =
        List.from(json['notices']).map((e) => Notice.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalNotices'] = totalNotices;
    data['notices'] = notices.map((e) => e.toJson()).toList();
    return data;
  }
}

class Notice {
  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String title;
  late final String description;
  late final String createdAt;
  late final String updatedAt;

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
