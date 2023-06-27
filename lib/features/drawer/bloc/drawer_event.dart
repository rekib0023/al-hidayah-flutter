part of 'drawer_bloc.dart';

@immutable
abstract class DrawerEvent {}

class DrawerInitialEvent extends DrawerEvent {}

class DrawerMenuItemClickedEvent extends DrawerEvent {
  final String itemName;

  DrawerMenuItemClickedEvent({required this.itemName});
}
