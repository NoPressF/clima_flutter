import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/utilities/debugging.dart';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode != 200) {
      debugLocationStatusMessage = "Error response code ${response.statusCode}";
      return;
    }

    return jsonDecode(response.body);
  }
}