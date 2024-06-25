import 'package:flutter/material.dart';
import 'package:hive_readng_list/model/book.dart';
import 'package:hive_readng_list/widgets/book_progress_indicator.dart';

class DisplayBookDialog extends StatelessWidget {
  final Book book;
  const DisplayBookDialog({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(book.title),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.author),
                  Text(book.genre),
                  Text(book.readingStatus)
                ],
              ),
              BookProgressIndicator(
                currentPage: book.currentPage,
                totalPage: book.totalPage,
              ),
            ],
          ),
          Text(book.description),
          Row(
            children: [
              Text(
                  '${book.currentPage.toString()} / ${book.totalPage.toString()}')
            ],
          )
        ],
      ),
    );
  }
}
