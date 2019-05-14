class Video {
  final String id;
  final String titulo;
  final String thumbnail;
  final String channel;

  Video({this.id, this.titulo, this.thumbnail, this.channel});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id"))
      return Video(
        id: json["id"]["videoId"],
        titulo: json["snippet"]["title"],
        thumbnail: json["snippet"]["thumbnails"]["high"]["url"],
        channel: json["snippet"]["channelTitle"],
      );
    else
      return Video(
        id: json["videoId"],
        titulo: json["titulo"],
        thumbnail: json["thumbnail"],
        channel: json["channel"],
      );
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": id,
      "titulo": titulo,
      "thumbnail": thumbnail,
      "channel": channel
    };
  }
}
