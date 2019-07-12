import 'dart:convert';

import 'package:http/http.dart' as http;

const kUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class TickerData {
  Future<double> getConvertValue(
      {String crytpo = 'BTC', String currency}) async {
    http.Response response = await http.get('$kUrl/$crytpo$currency');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return (json['last'] as double);
    } else {
      print(response.statusCode);
      throw UnsupportedError('An error has happened');
    }
  }
}
