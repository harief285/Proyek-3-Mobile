class Riwayat {
  String? id;
  String? user_id;
  String? prediksi;
  String? percentage;
  String? gambar;
  String? createdAt;
  String? updateAt;

  Riwayat({
    required this.id,
    required this.user_id,
    required this.prediksi,
    required this.percentage,
    required this.gambar,
    required this.createdAt,
    required this.updateAt,
  });

  factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
    id: json["id"],
    user_id: json["user_id"],
    prediksi: json["prediksi"],
    percentage: json["percentage"],
    gambar: json["gambar"],
    createdAt: json["created_at"],
    updateAt: json["update_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "prediksi": prediksi,
    "Persentase": percentage,
    "gambar": gambar,
    "created_at": createdAt,
    "update_at": updateAt,
  };
}