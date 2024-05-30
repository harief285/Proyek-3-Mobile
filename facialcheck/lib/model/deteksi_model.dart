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
      prediction: json['Prediction'] ?? '',
      percentage: json['Percentage'] ?? '',
      imagePath: json['ImagePath'] ?? '',
      fileName: json['FileName'] ?? '',
    );
  }
}
