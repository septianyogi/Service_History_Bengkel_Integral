import 'dart:convert';

import 'package:bengkel_service/models/service_model.dart';

MainServiceModel mainServiceModelFromJson(String str) =>
  MainServiceModel.fromJson(json.decode(str));

String mainServiceModelToJson(MainServiceModel data) => json.encode(data.toJson());

class MainServiceModel{
  List<ServiceModel> data;

  MainServiceModel({
    required this.data,
  });

  factory MainServiceModel.fromJson(Map<String, dynamic> json) => MainServiceModel(
    data: List<ServiceModel>.from(
      json["data"].map((x) => ServiceModel.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson()))
  };
}