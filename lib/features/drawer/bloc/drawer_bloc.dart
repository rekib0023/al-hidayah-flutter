import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    // on<DrawerInitialEvent>(drawerInitialEvent);
    on<DrawerMenuItemClickedEvent>(drawerMenuItemClickedEvent);
  }

  FutureOr<void> drawerInitialEvent(
      DrawerInitialEvent event, Emitter<DrawerState> emit) {}

  FutureOr<void> drawerMenuItemClickedEvent(
      DrawerMenuItemClickedEvent event, Emitter<DrawerState> emit) {
    switch (event.itemName) {
      case 'home':
        emit(DrawerHomeButtonClickActionState());
      case 'overview':
        emit(DrawerOverivewButtonClickActionState());
      case 'student-overview':
        emit(DrawerStudentOverivewButtonClickActionState());
      case 'management-overview':
        emit(DrawerManagementOverivewButtonClickActionState());
      case 'employee-overview':
        emit(DrawerEmployeeOverivewButtonClickActionState());
      case 'announcements':
        emit(DrawerAnnouncementsButtonClickActionState());
      default:
        emit(DrawerHomeButtonClickActionState());
    }
  }
}
