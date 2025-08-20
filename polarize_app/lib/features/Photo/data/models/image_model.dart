import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();
final DateTime currentDay = DateTime.now();
final DateTime date = DateTime(
  currentDay.year,
  currentDay.month,
  currentDay.day,
);

class ImageModel {
  final String? id;
  final String imageUrl;
  final DateTime? createdAt;

  ImageModel({String? id, required this.imageUrl, DateTime? createdAt})
    : id = id ?? uuid.v4(),
      createdAt = createdAt ?? date;

  Map<String, dynamic> toMap() {
    return {'imageUrl': imageUrl, 'createdAt': Timestamp.fromDate(createdAt!)};
  }

  factory ImageModel.fromMap(Map<String, dynamic> map, String id) {
    return ImageModel(
      id: id,
      imageUrl: map['imageUrl'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
