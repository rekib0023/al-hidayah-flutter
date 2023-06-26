class User {
  String _firstName;
  String _lastName;
  String _email;
  DateTime _dob;
  String _address;
  String? _phone;
  String _type;
  String _id;

  User({
    required String firstName,
    required String lastName,
    required String email,
    required DateTime dob,
    required String address,
    required String type,
    required String id,
    String? phone,
  })  : _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _dob = dob,
        _address = address,
        _phone = phone,
        _type = type,
        _id = id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get email => _email;

  DateTime get dob => _dob;

  String get address => _address;

  String? get phone => _phone;

  String get type => _type;

  String get id => _id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      dob: DateTime.parse(json['dob']),
      address: json['address'],
      phone: json['phone'],
      type: json['type'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
      'dob': _dob.toIso8601String(),
      'address': _address,
      'phone': _phone,
      'type': _type,
      '_id': _id,
    };
  }
}
