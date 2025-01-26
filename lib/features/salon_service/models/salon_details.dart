class SalonDetailsModel {
  final int id;
  final String name;
  final String desc;
  final String image;
  final String rateAvg;
  final int countProviders;
  final String hourWork;
  final bool isOpen;
  final String? timeClose;
  final String timeOpen;
  final List<Provider> providers;
  final List<Appointment> appointments;
  final List<ServiceType> typeService;

  SalonDetailsModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.rateAvg,
    required this.countProviders,
    required this.hourWork,
    required this.isOpen,
    required this.timeClose,
    required this.timeOpen,
    required this.providers,
    required this.appointments,
    required this.typeService,
  });

  factory SalonDetailsModel.fromJson(Map<String, dynamic> json) {
    return SalonDetailsModel(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
      rateAvg: json['rate_avg'],
      countProviders: json['count_providers'],
      hourWork: json['hour_work'],
      isOpen: json['is_open'],
      timeClose: json['time_close'],
      timeOpen: json['time_open'],
      providers: List<Provider>.from(
          json['providers'].map((provider) => Provider.fromJson(provider))),
      appointments: List<Appointment>.from(
          json['appointments'].map((appointment) => Appointment.fromJson(appointment))),
      typeService: List<ServiceType>.from(
          json['type_service'].map((service) => ServiceType.fromJson(service))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'image': image,
      'rate_avg': rateAvg.toString(),
      'count_providers': countProviders,
      'hour_work': hourWork,
      'is_open': isOpen,
      'time_close': timeClose,
      'time_open': timeOpen,
      'providers': providers.map((provider) => provider.toJson()).toList(),
      'appointments': appointments.map((appointment) => appointment.toJson()).toList(),
      'type_service': typeService.map((service) => service.toJson()).toList(),
    };
  }
}

class Provider {
  final int id;
  final String name;
  final String avatar;
  final String nationality;
  final String rateAvg;

  Provider({
    required this.id,
    required this.name,
    required this.avatar,
    required this.nationality,
    required this.rateAvg,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      nationality: json['nationality'],
      rateAvg: json['rate_avg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'nationality': nationality,
      'rate_avg': rateAvg.toString(),
    };
  }
}

class Appointment {
  final int id;
  final String name;
  final String type;
  final String fromTime;
  final String toTime;

  Appointment({
    required this.id,
    required this.name,
    required this.type,
    required this.fromTime,
    required this.toTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      fromTime: json['from_time'],
      toTime: json['to_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'from_time': fromTime,
      'to_time': toTime,
    };
  }
}

class ServiceType {
  final int id;
  final String name;

  ServiceType({
    required this.id,
    required this.name,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
