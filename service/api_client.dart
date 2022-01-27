import 'dart:convert';

import 'package:http/http.dart' as http;
//030ee184bba99a63ad057e2781776013

class ApiClient{
  final Uri currencyURL= Uri.https("freecurrencyapi.net","/api/v2/latest",
  {"apikey":"76e04730-7273-11ec-acee-9f5caaa6236c"});



  Future<List<String>> getCurrencies() async{
    http.Response res= await http.get(currencyURL);
    if(res.statusCode==200){
      var body=jsonDecode(res.body);
      var list=body["data"];
      List<String> currencies=(list.keys).toList();
      print(currencies);
      return currencies;
    }else{
      throw Exception("Failed to connect to API");
    }
  }
}