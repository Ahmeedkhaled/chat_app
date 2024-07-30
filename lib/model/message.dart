class Message {
  static const String collectionName = "message";
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  int dateTime;

  Message({
    this.id = "",
    required this.roomId,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.dateTime,
  });

  // Named constructor to create an instance from a JSON map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      roomId: json['roomId'],
      content: json['content'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      dateTime: json['dateTime'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'dateTime': dateTime,
    };
  }
}
