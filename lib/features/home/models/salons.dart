class SalonsModel {
  final int id;
  final String name;
  final String desc;
  final String rateAvg;
  final String distance;
  final double countRate;
  final List<Service> services;

  SalonsModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.rateAvg,
    required this.distance,
    required this.countRate,
    required this.services,
  });

  factory SalonsModel.fromJson(Map<String, dynamic> json) {
    return SalonsModel(
      id: json["id"] as int,
      name: json["name"] as String,
      desc: json["desc"] as String,
      rateAvg: json["rate_avg"].toString(),
      distance: json["distance"].toString(),
      countRate: (json["count_rate"] as num).toDouble(),
      services: (json["services"] as List<dynamic>)
          .map((serviceJson) => Service.fromJson(serviceJson as Map<String, dynamic>))
          .toList(),
    );
  }
}


class Service {
  final int id;
  final String name;

  Service({
    required this.id,
    required this.name,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}