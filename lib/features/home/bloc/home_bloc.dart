import 'dart:async';

import 'package:al_hidayah/features/login/bloc/login_bloc.dart';
import 'package:al_hidayah/features/overview/data_domain/students.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) => emit(HomeInitial()));
    on<HomeGridButtonClickEvent>(homeGridButtonClickEvent);
  }

  FutureOr<void> homeGridButtonClickEvent(
      HomeGridButtonClickEvent event, Emitter<HomeState> emit) {
    String name = event.name;
    switch (name) {
      case "Calendar":
        emit(HomeGridCalendarClickedActionState());
        break;
      case "Store":
        emit(HomeGridStoreClickedActionState());
      case "Expenses":
        emit(HomeGridExpensesClickedActionState());
      default:
        emit(HomeInitial());
    }
  }
}
