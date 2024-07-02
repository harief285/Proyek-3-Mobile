class Riwayat {
  String? id;
  String? userId;
  String? prediksi;
  String? presentase; // Menggunakan presentase sesuai dengan database
  String? gambar;
  String? createdAt;
  String? updatedAt;

  Riwayat({
    required this.id,
    required this.userId,
    required this.prediksi,
    required this.presentase, // Menggunakan presentase sesuai dengan database
    required this.gambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
    id: json["id"],
    userId: json["user_id"],
    prediksi: json["prediksi"],
    presentase: json["presentase"], // Menggunakan presentase sesuai dengan database
    gambar: json["gambar"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "prediksi": prediksi,
    "presentase": presentase, // Menggunakan presentase sesuai dengan database
    "gambar": gambar,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
