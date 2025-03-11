import '../enums/apod_media_type.dart';
import '../enums/apod_reaction.dart';

class ApodModel {
  ApodModel({
    this.copyright,
    this.reaction,
    required this.date,
    required this.explanation,
    required this.hdUrl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  final String? copyright;
  final String date;
  final String explanation;
  final String hdUrl;
  final ApodMediaType mediaType;
  final String serviceVersion;
  final String title;
  final String url;
  final ApodReaction? reaction;

  Map<String, dynamic> toJson() {
    return {
      'copyright': copyright,
      'date': date,
      'explanation': explanation,
      'hdurl': hdUrl,
      'media_type': mediaType == ApodMediaType.image ? 'image' : 'video',
      'service_version': serviceVersion,
      'title': title,
      'url': url,
      'reaction': reaction == ApodReaction.like ? 'like' : 'unlike',
    };
  }

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
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
      reaction: json['reaction'] == ApodReaction.like.name
          ? ApodReaction.like
          : ApodReaction.unlike,
    );
  }

  ApodModel copyWith({
    String? copyright,
    String? date,
    String? explanation,
    String? hdUrl,
    ApodMediaType? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
    ApodReaction? reaction,
  }) {
    return ApodModel(
      copyright: copyright ?? this.copyright,
      date: date ?? this.date,
      explanation: explanation ?? this.explanation,
      hdUrl: hdUrl ?? this.hdUrl,
      mediaType: mediaType ?? this.mediaType,
      serviceVersion: serviceVersion ?? this.serviceVersion,
      title: title ?? this.title,
      url: url ?? this.url,
      reaction: reaction ?? this.reaction,
    );
  }
}
