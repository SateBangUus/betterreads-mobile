import 'package:flutter/material.dart';
import 'package:betterreads/cart/buybook.dart';

class bookInfoCard extends StatefulWidget {
  final Product bookInfo;
  final int index;
  final int lastIndex;
  const bookInfoCard({
    Key? key,
    required this.bookInfo,
    required this.index,
    required this.lastIndex,
  }) : super(key: key);

  @override
  State<bookInfoCard> createState() => _InfoBookCardState();
}

class _InfoBookCardState extends State<bookInfoCard> {
  bool dropDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: widget.index % 2 == 0 ? Color(0xffc5d7f2) : Color(0xffcfe2ff)),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(widget.bookInfo.imageLink),
                  width: 200.0, // Adjust the width as needed
                  height: 150.0,),
            Text(
              widget.bookInfo.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.bookInfo.author,
              style: TextStyle(
                fontSize: 12,
              ),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.bookInfo.description,
              style: TextStyle(
                fontSize: 12,
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Review",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  icon: dropDown
                      ? Icon(Icons.arrow_drop_up)
                      : Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      if (dropDown) {
                        dropDown = false;
                      } else {
                        dropDown = true;
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}