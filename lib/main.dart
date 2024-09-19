import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:pagination_task/src/data/apifetch.dart';
import 'package:pagination_task/src/presentation/bloc/api_bloc.dart';
import 'package:pagination_task/src/presentation/home/home.dart';


void main() {
  final dio = Dio();
  final passengerRepository = PassengerRepository(dio: dio);

  runApp(MyApp(passengerRepository: passengerRepository));
}

class MyApp extends StatelessWidget {
  final PassengerRepository passengerRepository;

  const MyApp({required this.passengerRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PassengerBloc(passengerRepository: passengerRepository),
        child: const PassengerPage(),
      ),
    );
  }
}
