import 'dart:convert';
import 'package:http/http.dart' as http;

class FetcherCart {
  String mainURL = "https://betterreads-k3-tk.pbp.cs.ui.ac.id";

  getCart() async {
    Uri uri = Uri.parse('$mainURL/cart/json');
    var result = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    if (result.statusCode == 200) {
      var jsonString = result.body;
      var jsonMap = json.decode(jsonString);
      return jsonMap;
    }
  }
}