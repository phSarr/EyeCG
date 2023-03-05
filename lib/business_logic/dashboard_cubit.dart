import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {

  //TODO create repo for bluetooth services

  DashboardCubit() : super(DashboardInitial());
}
