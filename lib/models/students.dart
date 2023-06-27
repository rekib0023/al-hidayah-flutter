import 'users.dart';

class Student {
  Student({
    required this.id,
    required this.user,
    required this.rollNumber,
    required this.batch,
    required this.classN,
    required this.parentsDetail,
  });
  late final String? id;
  late final User user;
  late final String? rollNumber;
  late final String? batch;
  late final String classN;
  late final String parentsDetail;

  Student.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = User.fromJson(json['user']);
    rollNumber = json['rollNumber'];
    batch = json['batch'];
    classN = json['class'];
    parentsDetail = json['parentsDetail'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user'] = user.toJson();
    data['batch'] = batch;
    data['class'] = classN;
    data['parentsDetail'] = parentsDetail;
    return data;
  }
}
