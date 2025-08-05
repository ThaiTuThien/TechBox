class PointModel {
  final int points;

  PointModel({required this.points});

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(points: json['points'] as int);
  }
}
