import 'package:chat_app/constant/images.dart';

class Category {
  static const String sportsId = "sports";
  static const String musicId = "music";
  static const String moviesId = "movies";
  String id;
  late String title;
  late String image;

  Category({
    required this.id,
    required this.title,
    required this.image,
  });

  Category.fromId(this.id) {
    if (id == sportsId) {
      title = "Sports";
      image = sportsImage;
    } else if (id == moviesId) {
      title = "Movies";
      image = moviesImage;
    } else if (id == musicId) {
      title = "Music";
      image = musicImage;
    }
  }

  static List<Category> getCategory() {
    return [
      Category.fromId(sportsId),
      Category.fromId(musicId),
      Category.fromId(moviesId)
    ];
  }
}
