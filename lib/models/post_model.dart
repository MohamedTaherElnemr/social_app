class PostModel {
  late String name;
  String? uId;
  String? image;
  late String dateTime;
  String? text;
  String? postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    this.postImage,
    required this.dateTime,
    this.text,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
