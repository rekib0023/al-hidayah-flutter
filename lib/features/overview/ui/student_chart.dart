import 'package:al_hidayah/features/overview/data_domain/student_chartdata.dart';
import 'package:al_hidayah/models/students.dart';
import 'package:flutter/material.dart';

import '../data_domain/chart_model.dart';

import 'package:charts_flutter_new/flutter.dart' as charts;

Widget buildBarChart(List<Student> students) {
  List<ChartData> chartData = getChartData(students);
  chartData.sort((a, b) => a.studentClass.compareTo(b.studentClass));

  List<charts.Series<ChartData, String>> seriesList = [
    charts.Series<ChartData, String>(
      id: 'Students',
      data: chartData,
      domainFn: (ChartData data, _) => data.studentClass,
      measureFn: (ChartData data, _) => data.count,
    ),
  ];

  return charts.BarChart(
    seriesList,
    animate: true,
    vertical: true,
    barRendererDecorator: charts.BarLabelDecorator<String>(),
    domainAxis: const charts.OrdinalAxisSpec(
      renderSpec: charts.SmallTickRendererSpec(
        labelRotation: 45,
      ),
    ),
    primaryMeasureAxis: const charts.NumericAxisSpec(
      renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
          fontSize: 12,
        ),
      ),
    ),
  );
}
