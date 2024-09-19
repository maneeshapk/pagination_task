class Passenger {
  final String id;
  final String name;
  final Airline airline;

  Passenger({required this.id, required this.name, required this.airline});

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      id: json['_id'],
      name: json['name'],
      airline: Airline.fromJson(json['airline'][0]),
    );
  }
}

class Airline {
  final String name;
  final String logo;

  Airline({required this.name, required this.logo});

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      name: json['name'],
      logo: json['logo'],
    );
  }
}
