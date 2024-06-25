import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String genre;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String readingStatus;
  @HiveField(5)
  final double currentPage;
  @HiveField(6)
  final double totalPage;
  Book(this.title, this.author, this.genre, this.description,
      this.readingStatus, this.currentPage, this.totalPage);
}
