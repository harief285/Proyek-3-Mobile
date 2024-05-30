class ApiResponse {
  final String prediction;
  final String percentage;
  final String imagePath;
  final String fileName;

  ApiResponse({
    required this.prediction,
    required this.percentage,
    required this.imagePath,
    required this.fileName,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      prediction: json['prediction'],
      percentage: json['percentage'],
      imagePath: json['image_path'],
      fileName: json['file_name'],
      );
  }
}
