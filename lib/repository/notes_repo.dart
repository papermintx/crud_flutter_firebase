import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_tutorial/models/notes_model.dart';

class NotesRepo {
  final CollectionReference _notes = FirebaseFirestore.instance.collection('notes');

  Future<DocumentReference<Object?>> addNote(String note) async {
    return await _notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<List<NotesModel>> getNotes() {
    return _notes.orderBy('timestamp', descending: true).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => NotesModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> deleteNotes(String id) async {
    await _notes.doc(id).delete();
  }

  Future<void> updateNotes(String id, String note) async {
    await _notes.doc(id).update({
      'note': note,
    });
  }
}
