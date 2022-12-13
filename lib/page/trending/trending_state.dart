part of 'trending_cubit.dart';

class TrendingState extends Equatable {
  const TrendingState({
    this.loadStatus,
  });

  final LoadStatus? loadStatus;

  TrendingState copyWith({
    LoadStatus? loadStatus,
  }) {
    return TrendingState(loadStatus: loadStatus ?? this.loadStatus);
  }

  @override
  List<Object?> get props => [
        loadStatus,
      ];
}
