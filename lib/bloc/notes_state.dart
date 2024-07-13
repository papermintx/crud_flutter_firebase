part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<NotesModel> notes;

  NotesLoaded({required this.notes});
}

final class NotesError extends NotesState {
  final String message;

  NotesError({required this.message});
}


