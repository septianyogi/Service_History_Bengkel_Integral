// ignore_for_file: unused_import

import 'dart:convert';

import 'package:bengkel_service/models/serviceItem_model.dart';

class ServiceModel {
    String noPlat;
    String mobil;
    String pemilik;
    String noPemilik;
    DateTime createdAt;
    DateTime updatedAt;
    List<ServiceItemModel> services;

    ServiceModel({
        required this.noPlat,
        required this.mobil,
        required this.pemilik,
        required this.noPemilik,
        required this.createdAt,
        required this.updatedAt,
        required this.services
    });

    factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        noPlat: json["no_plat"],
        mobil: json["mobil"],
        pemilik: json["pemilik"],
        noPemilik: json["no_pemilik"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        
        services: List<ServiceItemModel>.from(json["services"].map((x) => ServiceItemModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "no_plat": noPlat,
        "mobil": mobil,
        "pemilik": pemilik,
        "no_pemilik": noPemilik,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}