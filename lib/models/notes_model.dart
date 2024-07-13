import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String id;
  String note;
  Timestamp timestamp;

  NotesModel({required this.id, required this.note, required this.timestamp});

  factory NotesModel.fromMap(Map<String, dynamic> data, String id) {
    return NotesModel(id: id, note: data['note'], timestamp: data['timestamp']);
    
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'timestamp': timestamp,
    };
  }
}
