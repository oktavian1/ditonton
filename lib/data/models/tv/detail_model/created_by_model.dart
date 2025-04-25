class CreatedByModel {
  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String? profilePath;

  CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json['id'],
        creditId: json['credit_id'],
        name: json['name'],
        gender: json['gender'],
        profilePath: json['profile_path'],
      );
}
