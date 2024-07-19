import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
Future<void> callApiFromCurl(String curlCommand) async {
  print('curl');
  // Extracting URL
  // RegExp urlRegex =RegExp(r"(?<=--location\s'|--location ')(https?://[^\s']*)");
  // String? url = urlRegex.firstMatch(curlCommand)?.group(1);

  RegExp urlRegex = RegExp(
    r"""curl\s+(?:--location\s+)?(?:-[LX]|--location|--location\s+--request|--request|\s+(GET|POST|PUT|DELETE))?\s*(GET|POST|PUT|DELETE)?\s*['"]?([^'"\s]+)['"]?""",
    caseSensitive: true,
 );

  String? url;
  List l=[];
  l.add(curlCommand);
  for (var curlCommand in l) {
    var match = urlRegex.firstMatch(curlCommand);
    if (match != null) {
      print('Extracted URL : ${match.group(3)}');
      String requestType = match.group(1)?.toUpperCase() ?? match.group(2)?.toUpperCase() ?? 'GET';
      print(requestType);
      url = match.group(3);
    } else {
      print('No URL found in: $curlCommand');
    }
  }

  if (url == null) {
    throw Exception('Invalid curl command: could not extract URL.');
  }

  // Extracting headers (-H or --header)
   RegExp headerPattern = RegExp(r"""--header\s+(["\'][^"\']*["\'])|-H\s+(["\'][^"\']*["\'])""");

  Iterable<Match> matches = headerPattern.allMatches(curlCommand);

  Map<String, String> headers = {};

  for (Match match in matches) {
    // Extract the header from either group 1 or group 2
    String? header = match.group(1) ?? match.group(2);

    if (header != null) {
      // Split header into key-value pair
      List<String> parts = header.split(': ');
      if (parts.length == 2) {
        headers[parts[0]] = parts[1]; // Add header to map
      }
    }
  }

  // Extracting data (-d or --data)
  String? data;
  RegExp dataRegex = RegExp(r"""--data\s+(["\'][\s\S]+[^"\']*[\s\S]+["\'])|-d\s+(["\'][\s\S]+[^"\']*[\s\S]+["\'])""");
  data = dataRegex.allMatches(curlCommand).first.group(1) ?? dataRegex.allMatches(curlCommand).first.group(2);


  print("$headers -  $url  ");
  print("= $data");

  // Making HTTP request
  // try {
  //   var response = await http.post(
  //     Uri.parse(url),
  //     // headers: {
  //     //   'Content-Type': 'application/json',
  //     //   ...Map.fromIterable(headers, key: (item) => item.split(':')[0], value: (item) => item.split(':')[1]),
  //     // },
  //     body: data != null ? jsonEncode(json.decode(data)) : null,
  //   );
  //
  //   // Handle response
  //   if (response.statusCode == 200) {
  //     print('API call successful: ${response.body}');
  //     // Process response as needed
  //   } else {
  //     print('Failed to call API: ${response.statusCode}');
  //     // Handle error response
  //   }
  // } catch (e) {
  //   print('Error calling API: $e');
  //   // Handle network or parsing errors
  // }
}


