import 'package:bloc/bloc.dart';
import 'package:crud_tutorial/models/notes_model.dart';
import 'package:crud_tutorial/repository/notes_repo.dart';
import 'package:flutter/material.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepo notesRepo;

  NotesBloc({required this.notesRepo}) : super(NotesInitial()) {
    on<AddNote>((event, emit) async {
      try {
        await notesRepo.addNote(event.note);
        // add(GetNotes());
      } catch (e) {
        emit(NotesError(message: e.toString()));
      }
    });

    on<GetNotes>((event, emit) async {
      // emit(NotesLoading()); // Emit loading state
      try {
        await emit.forEach<List<NotesModel>>(
          notesRepo.getNotes(),
          onData: (notes) => NotesLoaded(notes: notes),
        );
      } catch (e) {
        emit(NotesError(message: e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        await notesRepo.deleteNotes(event.id);
        // add(GetNotes());
      } catch (e) {
        emit(NotesError(message: e.toString()));
      }
    });

    on<UpdateNote>((event, emit) async {
      try {
        await notesRepo.updateNotes(event.id, event.note);
        // add(GetNotes());
      } catch (e) {
        emit(NotesError(message: e.toString()));
      }
    });
  }
}
