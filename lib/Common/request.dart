import 'dart:convert';
import 'dart:developer';
import 'package:attendance/Common/shared_pref.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Utils/path.dart';

apiPost({required String path, bool login = false, Object? body}) async {
  String? accessToken = await StorageService().getStringData('accessToken');
  String? token = await StorageService().getStringData('token');
  try {
    BotToast.showLoading();
    final response = await http.post(Uri.parse('$apiPath$path'),
        headers: login
            ? {}
            : {
                "Authorization": 'Bearer $token',
              },
        body: login ? jsonEncode({"token": accessToken}) : jsonEncode(body));
    var request = await json.decode(response.body);
    if (response.statusCode == 200 && request['success']) {
      BotToast.closeAllLoading();
      return request;
    } else {
      BotToast.closeAllLoading();
      toast(text: request['error']);
      return request;
    }
  } catch (e) {
    BotToast.closeAllLoading();
    log(e.toString());
  }
}

apiGet({required String path, Object? body}) async {
  String? token = await StorageService().getStringData('token');
  try {
    BotToast.showLoading();
    final response = await http.get(
      Uri.parse('$apiPath$path'),
      // headers: {
      //   "Authorization": "Bearer $token",
      // },
    );
    var request = await json.decode(response.body);
    if (response.statusCode == 200 && request['success']) {
      BotToast.closeAllLoading();
      return request;
    } else {
      BotToast.closeAllLoading();
      toast(text: request['error']);
      return request;
    }
  } catch (e) {
    BotToast.closeAllLoading();
    log(e.toString());
  }
}

apiPut({required String path, Object? body}) async {
  String? token = await StorageService().getStringData('token');
  try {
    BotToast.showLoading();
    final response = await http.put(Uri.parse('$apiPath$path'),
        headers: {
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body));
    var request = await json.decode(response.body);
    if (response.statusCode == 200 && request['success']) {
      BotToast.closeAllLoading();
      return request;
    } else {
      BotToast.closeAllLoading();
      toast(text: request['error']);
      return request;
    }
  } catch (e) {
    BotToast.closeAllLoading();
    log(e.toString());
  }
}

toast({required String? text}) {
  return BotToast.showText(
      text: text ?? '',
      contentColor: Colors.grey.shade800,
      textStyle: const TextStyle(color: Colors.white, fontSize: 15));
}
