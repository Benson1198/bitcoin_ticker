import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class BitcoinData {
//  BitcoinData(this.cryptoType, this.country);
//  final String cryptoType;
//  final String country;
  final apiKey = '02523CE5-39F1-4850-8EB5-CBA27A4CF267';

  Future<dynamic> getRate(String cryptoType, String country) async {
    String urlLink =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoType/$country?apikey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(urlLink);

    var data = await networkHelper.getData();
    var rate = await data['rate'];
    return rate;
  }
}
