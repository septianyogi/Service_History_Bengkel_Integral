

// ignore_for_file: file_names


class ServiceItemModel {
    int id;
    String noPlat;
    DateTime tanggal;
    String jasa;
    String barang;
    DateTime createdAt;
    DateTime updatedAt;

    ServiceItemModel({
        required this.id,
        required this.noPlat,
        required this.tanggal,
        required this.jasa,
        required this.barang,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ServiceItemModel.fromJson(Map<String, dynamic> json) => ServiceItemModel(
        id: json["id"],
        noPlat: json["no_plat"],
        tanggal: DateTime.parse(json["tanggal"]),
        jasa: json["jasa"],
        barang: json["barang"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_plat": noPlat,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jasa": jasa,
        "barang": barang,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}