part of 'bottomnav_cubit.dart';

class BottomnavState extends Equatable {
  final String bottomNavItems;
  final int index;

  const BottomnavState({required this.bottomNavItems, required this.index});

  @override
  List<Object> get props => [bottomNavItems, index];
}
