import 'package:flutter/material.dart';

class FavoriteGenreCard extends StatelessWidget {
  final String genre;
  final int count;
  final int index;

  const FavoriteGenreCard(
      {Key? key, required this.genre, required this.count, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: (index == 0)
              ? Colors.amber[700]
              : (index == 1)
                  ? Colors.white54
                  : (index == 2)
                      ? const Color.fromARGB(255, 120, 53, 15)
                      : ThemeData.dark().cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(genre,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width / 18,
                      fontWeight: FontWeight.bold)),
            ],
          )),
          const SizedBox(width: 10),
          Text(count.toString(),
              style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width / 14,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
