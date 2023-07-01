import 'package:al_hidayah/features/calendar/bloc/calendar_bloc.dart';
import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/utils/helpers.dart';
import 'package:al_hidayah/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarEventForm extends StatefulWidget {
  const CalendarEventForm({super.key, required this.bloc});

  final CalendarBloc bloc;

  @override
  State<CalendarEventForm> createState() => _CalendarEventFormState();
}

class _CalendarEventFormState extends State<CalendarEventForm> {
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  bool _isAllDay = false;

  String? _startDateErrorText;
  String? _endDateErrorText;
  String? _subjectErrorText;
  String? _selectedRecurrence;

  Map<String, String> recurrenceDropdown = {
    "Do not repeat": "",
    "Daily": "DAILY",
    "Weekly": "WEEKLY",
    "Monthly": "MONTHLY",
    "Every weekday": "EVERYWEEKDAY",
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: _subjectController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return 'Subject is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Subject',
                    errorText: _subjectErrorText,
                  ),
                ),
                const SizedBox(height: 20),
                Builder(
                  builder: (BuildContext context) => TextFormField(
                    controller: _startTimeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: const Icon(Icons.schedule),
                      labelText: 'Start Time',
                      errorText: _startDateErrorText,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Start date is required';
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? selectedDateTime =
                          await _selectDateTime(DateTime.now());

                      if (selectedDateTime != null) {
                        _startTimeController.text =
                            DateFormat.yMd().add_jm().format(selectedDateTime);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Builder(
                  builder: (BuildContext context) => TextFormField(
                    controller: _endTimeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: const Icon(Icons.schedule),
                      labelText: 'End Time',
                      errorText: _endDateErrorText,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'End date is required';
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? selectedDateTime =
                          await _selectDateTime(DateTime.now());
                      if (selectedDateTime != null) {
                        _endTimeController.text =
                            DateFormat.yMd().add_jm().format(selectedDateTime);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedRecurrence,
                        onChanged: (value) {
                          setState(() {
                            _selectedRecurrence = value;
                          });
                        },
                        items: recurrenceDropdown.entries
                            .map((entry) => DropdownMenuItem<String>(
                                  value: entry.value,
                                  child: Text(entry.key),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: 'Repeat',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('All Day'),
                        value: _isAllDay,
                        onChanged: (value) {
                          setState(() {
                            _isAllDay = value ?? false;

                            DateTime startTime = DateFormat('M/d/yyyy h:mm a')
                                .parse(_startTimeController.text);
                            DateTime endTime = DateTime(startTime.year,
                                startTime.month, startTime.day + 1);
                            _endTimeController.text =
                                DateFormat.yMd().add_jm().format(endTime);
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: _validateForm,
                    text: "Create",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Cancel",
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _selectDateTime(DateTime initialDateTime) async {
    final DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDateTime != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDateTime),
      );

      if (selectedTime != null) {
        final DateTime combinedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        return combinedDateTime;
      }
    }

    return null;
  }

  void _validateForm() {
    setState(() {
      _subjectErrorText =
          _subjectController.text.isEmpty ? 'Subject is required' : null;
      _startDateErrorText =
          _startTimeController.text.isEmpty ? 'Start date is required' : null;
      _endDateErrorText =
          _endTimeController.text.isEmpty ? 'End date is required' : null;
    });

    if (_startDateErrorText == null &&
        _endDateErrorText == null &&
        _subjectErrorText == null) {
      DateFormat dateTimeFormat = DateFormat('M/d/yyyy h:mm a');
      Appointment appointment = Appointment(
        startTime: dateTimeFormat.parse(_startTimeController.text),
        endTime: dateTimeFormat.parse(_endTimeController.text),
        subject: _subjectController.text,
        isAllDay: _isAllDay,
        color: getRandomColor(),
        startTimeZone: 'India Standard Time',
        endTimeZone: 'India Standard Time',
      );
      if (_selectedRecurrence != "") {
        appointment.recurrenceRule = 'FREQ=$_selectedRecurrence';
      }

      widget.bloc.add(CalendarEventCreate(appointment));
      Navigator.pop(context);
    }
  }
}
