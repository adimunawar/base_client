// ignore_for_file: empty_catches, dead_code

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:latihan100/helper/app_exception.dart';

class BaseClient {
  //get
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(uri).timeout(const Duration(seconds: 20));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }
}

dynamic _processResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = utf8.decode(response.bodyBytes);
      return responseJson;
      break;
    case 201:
      var responseJson = utf8.decode(response.bodyBytes);
      return responseJson;
      break;
    case 400:
      throw BadRequestException(
          utf8.decode(response.bodyBytes), response.request!.url.toString());
    case 401:
      throw UnAuthorizedException(
          utf8.decode(response.bodyBytes), response.request!.url.toString());
    case 403:
      throw BadRequestException(
          utf8.decode(response.bodyBytes), response.request!.url.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured with code : ${response.statusCode}',
          response.request!.url.toString());
  }
}
