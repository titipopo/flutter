import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottomnav_state.dart';

class BottomnavCubit extends Cubit<BottomnavState> {
  BottomnavCubit()
      : super(
            const BottomnavState(bottomNavItems: AppRouters.intiial, index: 0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const BottomnavState(bottomNavItems: AppRouters.home, index: 0));
        break;
      case 1:
        emit(const BottomnavState(
            bottomNavItems: AppRouters.settings, index: 1));
        break;
      case 2:
        emit(
            const BottomnavState(bottomNavItems: AppRouters.profile, index: 2));
        break;
    }
  }
}
