enum ApodMediaType { image, video }

class ApodMapper {
  ApodMapper({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdUrl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  final String copyright;
  final String date;
  final String explanation;
  final String hdUrl;
  final ApodMediaType mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  factory ApodMapper.fromJson(Map<String, dynamic> json) {
    return ApodMapper(
      copyright: json['copyright'] ?? '',
      date: json['date'] ?? '',
      explanation: json['explanation'] ?? '',
      hdUrl: json['hdurl'] ?? '',
      mediaType: json['media_type'] != null && json['media_type'] == 'image'
          ? ApodMediaType.image
          : ApodMediaType.video,
      serviceVersion: json['service_version'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
