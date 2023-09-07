import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ArticleModel {
  final int artId;
  final String image;
  final String title;
  final String description;
  final String likes;
  final String views;
  final String addDate;
  final String username;
  final String avatar;
  final String profession;
  final int userId;
  final String hashtag;

  ArticleModel({
    required this.avatar,
    required this.profession,
    required this.username,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.addDate,
    required this.artId,
    required this.likes,
    required this.views,
    required this.hashtag,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        hashtag: json["hashtag"] as String? ?? "",
        avatar: json["avatar"] as String? ?? "",
        profession: json["profession"] as String? ?? "",
        username: json["username"] as String? ?? "",
        userId: json["user_id"] as int? ?? 0,
        title: json["title"] as String? ?? "",
        description: json["description"] as String? ?? "",
        image: json["image"] as String? ?? "",
        addDate: json["add_date"] as String? ?? "",
        artId: json["art_id"] as int? ?? 0,
        likes: json["likes"] as String? ?? "",
        views: json["views"] as String? ?? "");
  }

  ArticleModel copyWith(
      {int? artId,
        String? image,
        String? title,
        String? description,
        String? likes,
        String? views,
        String? addDate,
        String? username,
        String? avatar,
        String? profession,
        int? userId,
        String? hashtag}) =>
      ArticleModel(
          avatar: avatar ?? this.avatar,
          profession: profession ?? this.profession,
          username: username ?? this.username,
          userId: userId ?? this.userId,
          title: title ?? this.title,
          description: description ?? this.description,
          image: image ?? this.image,
          addDate: addDate ?? this.addDate,
          artId: artId ?? this.artId,
          likes: likes ?? this.likes,
          views: views ?? this.views,
          hashtag: hashtag ?? this.hashtag);

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "profession": profession,
      "userId": userId,
      "title": title,
      "description": description,
      "likes": likes,
      "views": views,
      "addDate": addDate,
      "username": username,
      "avatar": avatar,
      "hashtag": hashtag,
    };
  }

  Future<FormData> getFormData() async {
    XFile file = XFile(image);
    String fileName = file.path.split('/').last;
    return FormData.fromMap({
      "title": title,
      "description": description,
      "hashtag": hashtag,
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
  }

  @override
  String toString() {
    return '''
    
    "title":$title,
    "title":$description,
    "title":$hashtag,
    "title":$image,
    "title":$avatar,
    "title":$addDate,
    "title":$artId,
    "title":$likes,
    "title":$views,
    "title":$profession,
    "title":$username,
   
    ''';
  }
}
