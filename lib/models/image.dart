class MovieImage {
  final String filePath;
  final double? aspectRatio;
  final int? height;
  final int? width;

  MovieImage({
    required this.filePath,
    this.aspectRatio,
    this.height,
    this.width,
  });

  factory MovieImage.fromJson(Map<String, dynamic> json) {
    return MovieImage(
      filePath: json['file_path'],
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      height: json['height'],
      width: json['width'],
    );
  }
}
