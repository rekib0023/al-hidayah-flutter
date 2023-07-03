import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:flutter/material.dart';

class PreAdmission extends StatefulWidget {
  const PreAdmission({super.key});

  @override
  State<PreAdmission> createState() => _PreAdmissionState();
}

class _PreAdmissionState extends State<PreAdmission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Pre Admission"),
    );
  }
}
