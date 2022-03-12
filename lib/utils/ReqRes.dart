import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ReqRes{
  Future get(String url) async{
    var resBody;
    var res= await http
        .get(Uri.parse(url));
    resBody=json.decode(res.body);
    return resBody;
  }
}