import 'package:crud_tutorial/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotesBloc>().add(GetNotes());
  }
  final TextEditingController controller = TextEditingController();
  void openNoteBook() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Note'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter your note',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // add note
                  context.read<NotesBloc>().add(
                        AddNote(note: controller.text),
                      );
                  controller.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Tutorial'),
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.note),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // delete note
                      context.read<NotesBloc>().add(DeleteNote(id: note.id));
                    },
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Update Note'),
                            content: TextField(
                              controller: controller..text = note.note,
                              decoration: const InputDecoration(
                                hintText: 'Enter your note',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // update note

                                  context.read<NotesBloc>().add(
                                        UpdateNote(
                                          id: note.id,
                                          note: controller.text,
                                        ),
                                      );
                                  controller.clear();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Update'),
                              ),
                            ],
                          );
                        });
                  },
                );
              },
            );
          } else if (state is NotesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBook,
        child: const Icon(Icons.add),
      ),
    );
  }
}
