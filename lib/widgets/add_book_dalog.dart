import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_readng_list/model/book.dart';

class AddBookDialog extends StatelessWidget {
  AddBookDialog({super.key,required this.bookBox});

  final Box<Book>? bookBox;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _readingStatusController =
      TextEditingController();
  final TextEditingController _currentPageController = TextEditingController();
  final TextEditingController _totalPageController = TextEditingController();

  double doubleParse(TextEditingController controller) {
    String value = controller.text;
    if (value.isNotEmpty) {
      return double.parse(value);
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new Book'),
      content: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(_titleController, 'Title'),
                customTextField(_authorController, 'Author'),
                customTextField(_genreController, 'Genre'),
                customTextField(_descriptionController, 'Description'),
                customTextField(_readingStatusController, 'Status'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        child: customTextField(
                            _currentPageController, 'Current Page')),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        child: customTextField(
                            _totalPageController, 'Total Page')),
                  ],
                )
              ],
            )),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              log(bookBox!.keys.toString());
            },
            child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            double currentPage = doubleParse(_currentPageController);
            double totalPage = doubleParse(_totalPageController);
            Book newBook = Book(
              _titleController.text,
              _authorController.text,
              _genreController.text,
              _descriptionController.text,
              'Completed Static',
              currentPage,
              totalPage,
            );
            if (_titleController.text.isNotEmpty &&
                _authorController.text.isNotEmpty &&
                _genreController.text.isNotEmpty &&
                _descriptionController.text.isNotEmpty &&
                _readingStatusController.text.isNotEmpty &&
                _currentPageController.text.isNotEmpty) {
              Navigator.of(context).pop(newBook);
              _titleController.clear();
              _authorController.clear();
              _genreController.clear();
              _descriptionController.clear();
              _readingStatusController.clear();
              _currentPageController.clear();
              _totalPageController.clear();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  TextFormField customTextField(
      TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(label: Text(label)),
    );
  }
}
