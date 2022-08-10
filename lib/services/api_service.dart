import 'dart:io';

import 'package:http/http.dart' as http;

class ApiServices {
  static var client = http.Client();

  static Future<http.Response> getPokemons() async {
    http.Response res;

    try {
      String url =
          "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
      res = await client.get(Uri.parse(url));
      return res;
    } on SocketException {
      // ignore: avoid_print
      print('No Internet connection 😑');
      return http.Response('Not Found', 404);
    }
  }
}
