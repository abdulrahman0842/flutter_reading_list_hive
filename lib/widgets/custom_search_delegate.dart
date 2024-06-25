import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_readng_list/model/book.dart';

class CustomSearchDelegate extends SearchDelegate {
  Box<Book>? bookBox;
  CustomSearchDelegate(this.bookBox);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    var results = bookBox!.values
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var result = results[index];
        return ListTile(
          title: Text(result.title),
          subtitle: Text(result.author),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestions = bookBox!.values
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        var suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion.title),
          subtitle: Text(suggestion.author),
          onTap: () {
            query = suggestion.title;
          },
        );
      },
    );
  }
}
