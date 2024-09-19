import 'package:dio/dio.dart';
import 'package:pagination_task/src/domain/model/model.dart';



class PassengerRepository {
  final Dio dio;
  final int size = 10; 

  PassengerRepository({required this.dio});

  Future<List<Passenger>> fetchPassengers(int page) async {
    final response = await dio.get(
      'https://api.instantwebtools.net/v1/passenger',
      queryParameters: {'page': page, 'size': size},
    );
    final data = response.data['data'] as List;
    return data.map((json) => Passenger.fromJson(json)).toList();
  }
}
