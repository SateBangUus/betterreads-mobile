import 'package:betterreads/user/models/user_review.dart';
import 'package:flutter/material.dart';

class TopReviewsCard extends StatelessWidget {
  final UserReview userReview;
  final int index;

  const TopReviewsCard(
      {Key? key, required this.userReview, required this.index})
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
                      ? Color.fromARGB(255, 120, 53, 15)
                      : ThemeData.dark().cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userReview.book.fields.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width / 18,
                      fontWeight: FontWeight.bold)),
              Text("by ${userReview.book.fields.author}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).width / 20,
                  )),
            ],
          )),
          SizedBox(width: 10),
          Text(userReview.rating.toString(),
              style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width / 14,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
