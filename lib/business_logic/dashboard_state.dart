part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardError extends DashboardState{
  //TODO actions taken once data is failed to be received/maybe connection error?
}

class DashboardLoaded extends DashboardState{
  //TODO actions taken once data received via bluetooth service (virtualize data)
}
