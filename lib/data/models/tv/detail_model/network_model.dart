class NetworkModel {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  NetworkModel({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        id: json['id'],
        name: json['name'],
        logoPath: json['logo_path'],
        originCountry: json['origin_country'],
      );
}
