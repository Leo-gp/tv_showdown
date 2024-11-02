import 'package:tv_showdown/domain/entities/show.dart';

class ShowModel extends Show {
  const ShowModel({
    required super.id,
    required super.name,
    required super.weight,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      id: json['id'] as int,
      name: json['name'] as String,
      weight: json['weight'] as int,
    );
  }
}
