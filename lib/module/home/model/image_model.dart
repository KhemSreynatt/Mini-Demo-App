class ImageModel {
  final String? id;
  final String? author;
  final int? width;
  final int? height;
  final String? url;
  final String? downloadUrl;
  ImageModel({
    this.author,
    this.downloadUrl,
    this.height,
    this.id,
    this.url,
    this.width,
  });
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        id: json['id'],
        author: json['author'],
        width: json['width'],
        height: json['height'],
        url: json['url'],
        downloadUrl: json['download_url']);
  }
  static List<ImageModel>? fromJsonList(List list) {
    if (list == []) return null;
    return list.map((e) => ImageModel.fromJson(e)).toList();
  }
}
