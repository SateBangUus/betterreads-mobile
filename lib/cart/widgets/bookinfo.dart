import 'package:betterreads/cart/screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class CheckoutCard extends StatefulWidget {
  final int id;
  final String title;
  final String author;
  final String imageURL;
  final int amount;
  final Function() refreshCheckout;
  final Function() refreshdelete;

  const CheckoutCard({
    super.key,
    required this.id,
    required this.title,
    required this.author,
    required this.imageURL,
    required this.amount,
    required this.refreshCheckout,
    required this.refreshdelete,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  late int _amount;
  final TextEditingController _amountController = TextEditingController();
  late CartWidget checkoutPage;

  @override
  void initState() {
    super.initState();
    _amount = widget.amount;
  }

  void _increment() {
    setState(() {
      _amount++;
    });
    widget.refreshCheckout();
  }

  void _decrement() {
    if (_amount > 1) {
      setState(() {
        _amount--;
      });
      widget.refreshCheckout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageURL,
              height: 120.0,
              width: 90.0,
              fit: BoxFit.cover,
            ),

            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Author: ${widget.author}'),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await request.postJson(
                              "https://betterreads-k3-tk.pbp.cs.ui.ac.id/buy/delete-book-flutter/",
                              jsonEncode(<String, int>{
                                'id': widget.id,
                              }));
                          widget.refreshdelete();
                          widget.refreshCheckout();
                        },
                      ),
                      const Spacer(), // Flexible space

                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () async {
                          await request.postJson(
                              "https://betterreads-k3-tk.pbp.cs.ui.ac.id/buy/decrease-book-flutter/",
                              jsonEncode(<String, int>{
                                'id': widget.id,
                              }));
                          _decrement();
                        },
                      ),
                      Expanded(
                          child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: _amount.toString(),
                          hintStyle: const TextStyle(color: Colors.green),
                        ),
                        onSubmitted: (value) async {
                          int newAmount = int.tryParse(value) ?? _amount;
                          if (newAmount <= 0) {
                            newAmount = _amount;
                          }})),

                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () async {
                          await request.postJson(
                              "https://betterreads-k3-tk.pbp.cs.ui.ac.id/buy/increase-book-flutter/",
                              jsonEncode(<String, int>{
                                'id': widget.id,
                              }));

                          _increment();
                        },
                      )]
                  ),
                ]
                  ),
            )
          ]
        ),
              ),
        );
  }}