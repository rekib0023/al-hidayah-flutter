part of 'drawer_bloc.dart';

@immutable
abstract class DrawerState {}

abstract class DrawerActionState extends DrawerState {}

class DrawerInitial extends DrawerState {}

class DrawerHomeButtonClickActionState extends DrawerActionState {}

class DrawerOverivewButtonClickActionState extends DrawerActionState {}

class DrawerStudentOverivewButtonClickActionState extends DrawerActionState {}

class DrawerManagementOverivewButtonClickActionState
    extends DrawerActionState {}

class DrawerEmployeeOverivewButtonClickActionState extends DrawerActionState {}

class DrawerAnnouncementsButtonClickActionState extends DrawerActionState {}
