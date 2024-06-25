import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_readng_list/widgets/add_book_dalog.dart';
import 'package:hive_readng_list/model/book.dart';
import 'widgets/book_list_tile.dart';
import 'widgets/custom_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Book>? bookBox;

  @override
  void initState() {
    super.initState();
    bookBox = Hive.box('booksBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildUI(),
      floatingActionButton: _addNewBookFloatingButton(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Reading Tracker'),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: CustomSearchDelegate(bookBox));
            },
            icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_list_rounded)),
      ],
    );
  }

  Widget _buildUI() {
    if (bookBox == null) {
      return const Center(
        child: Text('Box is Null'),
      );
    }
    // if (bookBox!.values.isEmpty) {
    //   log(bookBox!.keys.toString());
    //   return const Center(
    //     child: Text('No books in List'),
    //   );
    // }
    return BookListTile(bookBox: bookBox);
  }

  Widget _addNewBookFloatingButton() {
    return FloatingActionButton(
      onPressed: () async {
        var newBook = await showDialog(
          context: context,
          builder: (context) => AddBookDialog(
            bookBox: bookBox,
          ),
        );
        if (newBook != null) {
          bookBox!.add(newBook);
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
