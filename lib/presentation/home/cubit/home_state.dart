part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final bool isLoad;

  const HomeState({required this.isLoad});

  HomeState copyWith({bool? isLoad}) {
    return HomeState(
      isLoad: isLoad ?? this.isLoad,
    );
  }

  @override
  List<Object?> get props => [
        isLoad,
      ];
}
