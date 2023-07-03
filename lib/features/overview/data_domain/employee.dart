import 'package:al_hidayah/models/users.dart';

import '../../../models/attendance.dart';

class Employee {
  EmergencyContact? emergencyContact;
  BankDetails? bankDetails;
  String? sId;
  User? user;
  String? department;
  String? dateOfJoining;
  int? salary;
  int? employeeNumber;
  String? jobTitle;
  List<dynamic>? documents;
  List<Attendance>? attendance;

  Employee({
    this.emergencyContact,
    this.bankDetails,
    this.sId,
    this.user,
    this.department,
    this.dateOfJoining,
    this.salary,
    this.employeeNumber,
    this.jobTitle,
    this.documents,
    this.attendance,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    emergencyContact = json['emergencyContact'] != null
        ? EmergencyContact.fromJson(json['emergencyContact'])
        : null;
    bankDetails = json['bankDetails'] != null
        ? BankDetails.fromJson(json['bankDetails'])
        : null;
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    department = json['department'];
    dateOfJoining = json['dateOfJoining'];
    salary = json['salary'];
    employeeNumber = json['employeeNumber'];
    jobTitle = json['jobTitle'];
    if (json['documents'] != null) {
      documents = <Null>[];
      json['documents'].forEach((v) {
        documents!.add(v);
      });
    }

    attendance = List.from(json['attendance'])
        .map((e) => Attendance.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emergencyContact != null) {
      data['emergencyContact'] = emergencyContact!.toJson();
    }
    if (bankDetails != null) {
      data['bankDetails'] = bankDetails!.toJson();
    }
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['department'] = department;
    data['dateOfJoining'] = dateOfJoining;
    data['salary'] = salary;
    data['employeeNumber'] = employeeNumber;
    data['jobTitle'] = jobTitle;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    data['attendance'] = attendance!.map((e) => e.toJson()).toList();
    return data;
  }
}

class EmergencyContact {
  String? name;
  String? relationship;
  String? phoneNumber;

  EmergencyContact({this.name, this.relationship, this.phoneNumber});

  EmergencyContact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relationship = json['relationship'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['relationship'] = relationship;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class BankDetails {
  String? accountNumber;
  String? bankName;
  String? branch;
  String? iFSCCode;

  BankDetails({this.accountNumber, this.bankName, this.branch, this.iFSCCode});

  BankDetails.fromJson(Map<String, dynamic> json) {
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    branch = json['branch'];
    iFSCCode = json['IFSCCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountNumber'] = accountNumber;
    data['bankName'] = bankName;
    data['branch'] = branch;
    data['IFSCCode'] = iFSCCode;
    return data;
  }
}
