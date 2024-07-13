part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class AddNote extends NotesEvent {
  final String note;

  AddNote({required this.note});
}


final class GetNotes extends NotesEvent {}

final class DeleteNote extends NotesEvent {
  final String id;

  DeleteNote({required this.id});
}

final class UpdateNote extends NotesEvent {
  final String id;
  final String note;

  UpdateNote({required this.id, required this.note});
}
