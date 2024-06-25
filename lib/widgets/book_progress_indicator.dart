import 'package:flutter/material.dart';

class BookProgressIndicator extends StatefulWidget {
  const BookProgressIndicator({
    super.key,
    required this.currentPage,
    required this.totalPage,
  });

  final double currentPage;
  final double totalPage;

  @override
  State<BookProgressIndicator> createState() => _BookProgressIndicatorState();
}

class _BookProgressIndicatorState extends State<BookProgressIndicator> {
  late double percentage = calculatePercentage(widget.currentPage, widget.totalPage);

  double calculatePercentage(double currentPage, double totalPage) {
    return currentPage / totalPage * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(alignment: Alignment.center, children: [
        CircularProgressIndicator(
          value: widget.currentPage / widget.totalPage,
          backgroundColor: Colors.white,
          strokeAlign: 3,
          strokeWidth: 3,
        ),
        Text('${percentage.toStringAsFixed(1)}%')
      ]),
    );
  }
}
