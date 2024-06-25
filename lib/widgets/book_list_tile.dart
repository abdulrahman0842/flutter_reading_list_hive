import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_readng_list/model/book.dart';
import 'package:hive_readng_list/widgets/display_book_dialog.dart';

import 'book_progress_indicator.dart';

class BookListTile extends StatelessWidget {
  const BookListTile({
    super.key,
    required this.bookBox,
  });

  final Box<Book>? bookBox;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bookBox!.listenable(),
      builder: (context, Box<Book> box, _) {
        return Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: bookBox!.values.length,
                  itemBuilder: (context, index) {
                    var book = bookBox!.getAt(index);

                    return Card(
                        elevation: 4,
                        child: ListTile(
                            onLongPress: () {
                              bookBox!.deleteAt(index);
                            },
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    DisplayBookDialog(book: book),
                              );
                            },
                            title: Text(
                              book!.title,
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(book.author),
                                    Text(book.genre),
                                    Text(book.readingStatus),
                                  ],
                                ),
                                BookProgressIndicator(
                                  currentPage: book.currentPage,
                                  totalPage: book.totalPage,
                                )
                              ],
                            )));
                  }),
            ))
          ],
        );
      },
    );
  }
}
