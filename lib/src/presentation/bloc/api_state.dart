
import 'package:equatable/equatable.dart';
import 'package:pagination_task/src/domain/model/model.dart';

abstract class PassengerState extends Equatable {
  const PassengerState();

  @override
  List<Object> get props => [];
}

class PassengerInitial extends PassengerState {}

class PassengerLoading extends PassengerState {}

class PassengerLoaded extends PassengerState {
  final List<Passenger> passengers;
  final bool hasReachedMax;

  const PassengerLoaded({required this.passengers, this.hasReachedMax = false});

  PassengerLoaded copyWith({
    List<Passenger>? passengers,
    bool? hasReachedMax,
  }) {
    return PassengerLoaded(
      passengers: passengers ?? this.passengers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [passengers, hasReachedMax];
}

class PassengerError extends PassengerState {
  final String error;

  const PassengerError(this.error);

  @override
  List<Object> get props => [error];
}
