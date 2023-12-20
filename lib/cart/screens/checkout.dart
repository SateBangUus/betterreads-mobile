import 'dart:convert';

import 'package:betterreads/cart/screens/success.dart';
import 'package:flutter/material.dart';
import 'package:betterreads/cart/models/buybook.dart';
import 'package:betterreads/cart/widgets/bookinfo.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  Future<List<Product>> getProduct(CookieRequest request) async {
    var response = await request.get(
      'https://betterreads-k3-tk.pbp.cs.ui.ac.id/buy/get-product-flutter/',
    );

    List<Product> listBuy = [];
    for (var d in response) {
      if (d != null) {
        Product product = Product.fromJson(d);
        listBuy.add(product);
      }
    }
    
    return listBuy;
  }

  void refreshC() {
    final request = context.watch<CookieRequest>();
    setState(() {
      getProduct(request);
    });
  }

void refreshdel() {
    setState(() {
      Navigator.pop(context);
      Navigator.pushReplacement(context ,MaterialPageRoute(builder: (context) => CartWidget()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(
              255, 64, 64, 64), // Change to your desired color
          title: const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Better',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF236BF1),
                  fontSize: 22,
                ),
              ),
              Text(
                'Reads',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFFEC2F3F),
                  fontSize: 22,
                ),
              ),
            ],
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: FutureBuilder(
            future: getProduct(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text('No items in the cart!'),
                );
              } else {
                if (!snapshot.hasData) {
                  return const Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16, bottom: 8, left: 6, right: 6),
                          child: Text(
                            'You have no items in the cart!',
                            style: TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]));
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        // Replace the following with your actual search bar widget
                        const SizedBox(height: 30.0),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var cartItem = snapshot.data![index];
                            return CheckoutCard(
                              id: cartItem.id, // Assuming pk is the identifier for the book
                              title: cartItem.title,
                              author: cartItem.author,
                              imageURL: cartItem.imageLink,
                              amount: cartItem.amount, // Replace with the actual property
                              refreshCheckout: refreshC,
                              refreshdelete: refreshdel,
                            );
                          },
                        ),
                        const SizedBox(height: 50.0),
                        Card(
                          elevation: 3.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckoutWidget(),
                                        ),
                                          
                                      );
                                      await request.postJson(
                              "https://betterreads-k3-tk.pbp.cs.ui.ac.id/buy/submit-buy/", jsonEncode(<String, int>{})
                              );
                              refreshC();
                                      // Navigate back to the main page or perform other actions
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .blue, // Change to your desired color
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Buy',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])));
                }
              }
            }));
  }
}
