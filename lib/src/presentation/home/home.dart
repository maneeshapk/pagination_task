import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_task/src/presentation/bloc/api_bloc.dart';
import 'package:pagination_task/src/presentation/bloc/api_event.dart';
import 'package:pagination_task/src/presentation/bloc/api_state.dart';


class PassengerPage extends StatefulWidget {
  const PassengerPage({super.key});

  @override
  _PassengerPageState createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  late PassengerBloc _passengerBloc;
  final ScrollController _scrollController = ScrollController();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _passengerBloc = context.read<PassengerBloc>()..add(FetchPassengers(_page));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _page++;
      _passengerBloc.add(FetchPassengers(_page));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Passengers Details',selectionColor: Colors.black,)),
      body: BlocBuilder<PassengerBloc, PassengerState>(
        builder: (context, state) {
          if (state is PassengerLoading && _page == 0) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PassengerLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.passengers.length
                  : state.passengers.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.passengers.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final passenger = state.passengers[index];
                return ListTile(
                  leading: SizedBox(
                    width: 50, 
                    height: 50,
                    child: Image.network(
                      passenger.airline.logo,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.airplanemode_active_rounded); 
                      },
                    ),
                  ),
                  title: Text(passenger.name),
                  subtitle: Text(passenger.airline.name),
                );
              },
            );
          } else if (state is PassengerError) {
            return Center(child: Text('Failed to fetch passengers: ${state.error}'));
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
