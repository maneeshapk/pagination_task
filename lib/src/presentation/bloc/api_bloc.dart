import 'package:bloc/bloc.dart';
import 'package:pagination_task/src/data/apifetch.dart';
import 'package:pagination_task/src/presentation/bloc/api_event.dart';
import 'package:pagination_task/src/presentation/bloc/api_state.dart';

class PassengerBloc extends Bloc<PassengerEvent, PassengerState> {
  final PassengerRepository passengerRepository;

  PassengerBloc({required this.passengerRepository}) : super(PassengerInitial()) {
    on<FetchPassengers>(_onFetchPassengers);
  }

  Future<void> _onFetchPassengers(FetchPassengers event, Emitter<PassengerState> emit) async {
    if (state is PassengerLoaded && (state as PassengerLoaded).hasReachedMax) return;

    try {
      if (state is PassengerInitial || event.page == 0) {
        emit(PassengerLoading());
        final passengers = await passengerRepository.fetchPassengers(event.page);
        emit(PassengerLoaded(passengers: passengers, hasReachedMax: false));
      } else if (state is PassengerLoaded) {
        final currentState = state as PassengerLoaded;
        final passengers = await passengerRepository.fetchPassengers(event.page);
        emit(passengers.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : PassengerLoaded(
                passengers: currentState.passengers + passengers,
                hasReachedMax: false,
              ));
      }
    } catch (error) {
      emit(PassengerError(error.toString()));
    }
  }
}
