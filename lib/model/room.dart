class Room {
  static const String collectionName = 'room';
  String roomId;
  String title;
  String description;
  String categoryId;

  // Constructor
  Room({
    required this.roomId,
    required this.title,
    required this.description,
    required this.categoryId,
  });

  // fromJson method
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['categoryId'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': roomId,
      'title': title,
      'description': description,
      'categoryId': categoryId,
    };
  }
}
