import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
          toFirestore: (room, options) => room.toJson(),
        );
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: (snapshot, optians) =>
                Message.fromJson(snapshot.data()!),
            toFirestore: (message, optians) => message.toJson());
  }

  static Future<void> registerUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUser(String userId) async {
    var documentSnapshot = await getUserCollection().doc(userId).get();
    return documentSnapshot.data();
  }

  static Future<void> addRoomToFirestoreroom(Room room) async {
    var docRef = getRoomCollection().doc();
    room.roomId = docRef.id;
    return docRef.set(room);
  }

  static Future<void> deleteRoom(String roomId) async {
    return getRoomCollection().doc(roomId).delete().then((value) {
      print("Room Deleted");
    }).catchError((error) {
      print("Failed to delete room: $error");
    });
  }

  static Stream<QuerySnapshot<Room>> getRooms() {
    return getRoomCollection().snapshots();
  }

  static Future<void> insertMessage(Message message) async {
    var messageCollection = getMessageCollection(message.roomId);
    var docRef = messageCollection.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessagesFromFirestore(
      String roomId) {
    return getMessageCollection(roomId).orderBy("dateTime").snapshots();
  }
}
