import 'package:al_hidayah/features/overview/data_domain/management_service.dart';

import 'students.dart';

class ManagementRepository {
  final ManagementService _managementService = ManagementService();

  Future<List<Student>> getStudents() async {
    try {
      return await _managementService.getStudents();
    } catch (e) {
      throw Exception("Failed to load students");
    }
  }

  Future<List<Student>> getStudentsByClass(String classN) async {
    try {
      return await _managementService.getStudentsByClass(classN);
    } catch (e) {
      throw Exception("Failed to load students");
    }
  }

  Future<Student> createStudent(
    String firstName,
    String lastName,
    String email,
    String dob,
    String address,
    String phone,
    String className,
    String parentsDetail,
  ) async {
    Map<String, dynamic> student = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "dob": dob,
      "address": address,
      "phone": phone,
      "classN": className,
      "parentsDetail": parentsDetail,
    };

    try {
      return await _managementService.createStudent(student);
    } catch (e) {
      throw Exception("Failed to load students");
    }
  }
}
