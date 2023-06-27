import 'package:al_hidayah/features/overview/data_domain/management_service.dart';

import '../../../models/students.dart';

class ManagementRepository {
  final ManagementService _managementService = ManagementService();

  Future<List<Student>> getStudents() async {
    try {
      return await _managementService.getStudents();
    } catch (e) {
      throw Exception("Failed to load students");
    }
  }
}
