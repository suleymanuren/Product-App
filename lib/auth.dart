import 'package:http/http.dart' as http;

import 'dart:convert';

register(String email, contact, pass, conpass) async {
  Map data = {
    'Email': email,
    'Mobile': contact,
    'Password': pass,
    'RetypePassword': conpass,
  };
  print(data);

  String body = json.encode(data);
  var url = 'https://assignment-api.piton.com.tr/api/v1/user/register' as Uri;
  var response = await http.post(
    url,
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print('success');
  } else {
    print('error');
  }
}
