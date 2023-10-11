import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../Utils/Constants/globals.dart';
import 'app_exceptions.dart';
import 'package:flutter/material.dart';

class Api {
  static Future<dynamic> getRequestData(String apiEndPoint, BuildContext context) async {
    String apiAddress = baseUrl! + apiEndPoint + "api_key=$apiKey";
    print("URL: " + apiAddress);
    var responseJson;
    final response = await http.get(
      Uri.parse(apiAddress),
      headers: {
        'Content-type': 'application/json',
      },
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('Error', 408); // Request Timeout response status code
      },
    );
    responseJson = _returnListResponse(response);
    return responseJson;
  }

  static Future<dynamic> postRequestData(String apiEndPoint, Map<String, dynamic> body, BuildContext context,
      {bool sendToken = false, String? jsonBody}) async {
    String apiAddress = baseUrl! + apiEndPoint + "?api_key=$apiKey";
    print("URL: " + apiAddress);
    var responseJson;
    var response = await http
        .post(
      Uri.parse(apiAddress),
      body: jsonBody ?? jsonEncode(body),
      headers: {
              'Content-type': 'application/json',
            },
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('Error', 408); // Request Timeout response status code
      },
    );
    responseJson = _returnListResponse(response);
    return responseJson;
  }

  static Future<dynamic> putRequestData(String apiEndPoint, dynamic body, BuildContext context, {bool sendToken = false}) async {
    String apiAddress = "${baseUrl!}$apiEndPoint?api_key=$apiKey";
    print(apiAddress);
    var responseJson;
    try {
      var response = await http
          .put(
        Uri.parse(apiAddress),
        body: jsonEncode(body),
        headers: {
                'Content-type': 'application/json',
              },
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      responseJson = _returnListResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    }
  }

  static Future<dynamic> deleteRequestData(String apiEndPoint, BuildContext context, {bool sendToken = false}) async {
    String apiAddress = baseUrl! + apiEndPoint + "?api_key=$apiKey";
    print(apiAddress);
    var responseJson;
    try {
      var response = await http
          .delete(
        Uri.parse(apiAddress),
        headers: {
                'Content-type': 'application/json',
              },
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      responseJson = _returnListResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    }
  }
}

dynamic _returnListResponse(http.Response response) {
  print("StatusCode:  ${response.statusCode}");
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw UnauthorisedException(response.body.toString());
    case 404:
      throw RequestNotFoundException(response.body.toString());
    case 403:
      throw UnautorizationException(response.body.toString());
    case 408:
      var responseJson = "Request Timeout";
      return responseJson;
    case 500:
      throw InternalServerException(response.body.toString());
    case 503:
      throw ServerNotFoundException(response.body.toString());
    default:
      throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
