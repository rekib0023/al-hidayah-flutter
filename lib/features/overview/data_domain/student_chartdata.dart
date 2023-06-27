import 'package:al_hidayah/models/students.dart';

import 'chart_model.dart';

List<ChartData> getChartData(List<Student> students) {
  Map<String, int> classCounts = {};
  for (Student student in students) {
    String studentClass = student.classN;
    if (classCounts.containsKey(studentClass)) {
      classCounts[studentClass] = (classCounts[studentClass]! + 1);
    } else {
      classCounts[studentClass] = 1;
    }
  }
  List<ChartData> chartData = classCounts.entries.map((entry) {
    return ChartData(entry.key, entry.value);
  }).toList();

  return chartData;
}
