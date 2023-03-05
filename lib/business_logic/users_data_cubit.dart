import 'package:bloc/bloc.dart';
import 'package:eyecg/data/model/user_data.dart';
import 'package:eyecg/data/repo/user_repo.dart';
import 'package:meta/meta.dart';
/*
part 'users_data_state.dart';

class UsersDataCubit extends Cubit<UsersDataState> {
  final UserRepo userRepo;
  UsersDataCubit(this.userRepo) : super(UsersDataInitial());

  void emitSendUserData(UserData newUser){
    userRepo.sendUserData(newUser).then((newUser) {emit(SendUserData(newUser));} );
  }

}

*/
