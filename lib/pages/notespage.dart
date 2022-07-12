import 'package:fluent_ui/fluent_ui.dart' as dialog;
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pdf_reader/model/transaction.dart';
import 'package:pdf_reader/model/boxes.dart';

import '../notes/stickynote.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late dialog.TextEditingController controller;
  late final List<Transaction> transactions;
  late dialog.TextEditingController editingController;
  @override
  void initState() {
    controller = dialog.TextEditingController();
    editingController = dialog.TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('transaction').close();
    controller.dispose();
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: Scaffold(
          body: ValueListenableBuilder<Box<Transaction>>(
              valueListenable: Boxes.getTransaction().listenable(),
              builder: (context, box, _) {
                final transactions = box.values.toList().cast<Transaction>();
                return bildContent(transactions);
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                openDialog(context);
              },
              backgroundColor: Colors.white,
              child: const Icon(
                dialog.FluentIcons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CONTENT BODY
  Widget bildContent(List<Transaction> transactions) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final currentNote = transactions[index];

          return dialog.Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
            child: dialog.SizedBox(
                child: Stack(
              children: [
                StickyNoteContainer(
                    name: currentNote.name,
                    createdDate: currentNote.createdDate),
                dialog.Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(
                      dialog.FluentIcons.delete,
                      color: Colors.black,
                      size: 14,
                    ),
                    onPressed: () =>
                      deleteNote(currentNote)  
                  ),
                ),
              ],
            )),
          );
        });
  }

  // ADD NOTE
  Future addNote(String name) async {
    final transaction = Transaction()
      ..name = name
      ..createdDate = DateTime.now();
    final box = Boxes.getTransaction();
    box.add(transaction);
  }

  //EDIT NOTE
  void editTransaction(Transaction transact, String name) {
    transact.name = name;
    transact.save();
  }

  //DELETE NOTE
  void deleteNote(Transaction transact) {
    transact.delete();
  }

  void openDialog(BuildContext context) => dialog.showDialog(
      context: context,
      builder: (context) => dialog.ContentDialog(
            content: Material(
              child: TextField(
                maxLines: 10,
                controller: controller,
                decoration: const InputDecoration(
                  label: Text('Add Note'),
                ),
              ),
            ),
            actions: [
              dialog.TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              dialog.TextButton(
                onPressed: () {
                  addNote(controller.text);
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              )
            ],
          ));
}
