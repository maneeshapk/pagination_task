import 'package:equatable/equatable.dart';

abstract class PassengerEvent extends Equatable {
  const PassengerEvent();

  @override
  List<Object> get props => [];
}

class FetchPassengers extends PassengerEvent {
  final int page;

  const FetchPassengers(this.page);

  @override
  List<Object> get props => [page];
}