import 'package:al_hidayah/features/calendar/bloc/calendar_bloc.dart';
import 'package:al_hidayah/features/calendar/ui/create_event.dart';
import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class FCalendar extends StatefulWidget {
  const FCalendar({super.key});

  @override
  State<FCalendar> createState() => _FCalendarState();
}

class _FCalendarState extends State<FCalendar> {
  final CalendarBloc bloc = CalendarBloc();
  @override
  void initState() {
    bloc.add(CalendarEventInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: AppColors.primary,
            title: Text(
              "Calendar",
              style: AppTextStyles.title.copyWith(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: CalendarEventForm(bloc: bloc),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.event),
              ),
            ],
          ),
          body: SfCalendar(
            onTap: calendarTapped,
            view: CalendarView.month,
            dataSource: state is CalendarEventSuccessLoaded
                ? MeetingDataSource(state.appointments)
                : MeetingDataSource([]),
            initialSelectedDate: DateTime.now(),
            monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              dayFormat: 'EEE',
            ),
          ),
        );
      },
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments![0];

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Are you sure you want to delete this event?'),
          actions: [
            SecondaryButton(
              text: "No",
              color: AppColors.red,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            PrimaryButton(
              text: "Yes",
              onPressed: () {
                bloc.add(CalendarEventDelete(appointment));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
