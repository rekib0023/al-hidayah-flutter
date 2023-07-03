class Attendance {
  Attendance({
    required this.sid,
    required this.date,
    required this.isPresent,
    required this.subject,
  });
  late final String sid;
  late final DateTime date;
  late final bool isPresent;
  late final String? subject;

  Attendance.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    date = DateTime.parse(json['date']);
    isPresent = json['isPresent'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['isPresent'] = isPresent;
    data['subject'] = subject;
    return data;
  }
}
