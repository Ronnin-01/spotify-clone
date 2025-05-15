import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_spotify/domain/usecases/auth/get_user.dart';

import '../../../service_locator.dart';
import 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUseCase>().call();

    user.fold((l) {
      emit(ProfileInfoFailure());
    }, (userEntity) {
      ProfileInfoLoaded(userEntity: userEntity);
    });
  }
}
