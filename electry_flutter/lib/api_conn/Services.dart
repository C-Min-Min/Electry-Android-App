// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:electry_flutter/api_conn/Measurement.dart';
import 'package:electry_flutter/api_conn/User.dart';
import 'package:http/http.dart' as http;
import 'Device.dart';

class Services {
  static const ROOT = 'http://164.138.220.181:3000/devices/';
  static const _GET_ALL_ACTION = 'all';
  static const _SEARCH_ACTION = 'search';
  static const _EDIT_ACTION = 'edit';
  static const _GET_MEASUREMENTS_ACTION = 'measurements';
  //static const _SIGN_UP_ACTION = 'sign';
  static const _LOGIN_ACTION = 'login';

  static Future<List<Device>> getDevices() async {
    try {
      var map = Map<String, dynamic>();
      map['sub_api'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Device> list = parseResponse(response.body);
        return list;
      } else {
        return List<Device>();
      }
    } catch (e) {
      return List<Device>();
    }
  }

  static Future<List<Device>> searchDevice(int id) async {
    try {
      var map = Map<String, dynamic>();
      map['sub_api'] = _SEARCH_ACTION;
      map['search'] = id.toString();
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Device> dev = parseResponse(response.body);
        return dev;
      } else {
        return List<Device>();
      }
    } catch (e) {
      return List<Device>();
    }
  }

  static Future<List<Measurement>> getMeasurements(int id) async {
    try {
      var map = Map<String, dynamic>();
      map['sub_api'] = _GET_MEASUREMENTS_ACTION;
      map['id'] = id.toString();
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<Measurement> measure = parseMeasureResponse(response.body);
        return measure;
      } else {
        print("not 200: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static updateDevice(int id, String change, String dev) async {
    try {
      var map = Map<String, dynamic>();
      map['sub_api'] = _EDIT_ACTION;
      map['id'] = id.toString();
      map['change_set'] = change;
      map['dev_x'] = dev;
      final response = await http.post(ROOT, body: map);
      if (200 != response.statusCode) {
        print("not 200: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  static signUser(String username, String password, String email) async {
    try {
      var map = Map<String, dynamic>();
      map['sub_api'] = _LOGIN_ACTION;
      map['user'] = username;
      map['pass'] = password;
      map['email'] = email;
      final response = await http.post(ROOT, body: map);
      if (200 != response.statusCode) {
        print("not 200: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<User> loginUser(String userMail, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['sub_api'] = _LOGIN_ACTION;
      map['user'] = userMail;
      map['pass'] = password;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        User user = parseResponseUser(response.body)[0];
        return user;
      } else {
        print("not 200: ${response.statusCode}");
        return User();
      }
    } catch (e) {
      print(e);
      return User();
    }
  }

  static List<Device> parseResponse(String responseBody) {
    final parses = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parses.map<Device>((json) => Device.fromJson(json)).toList();
  }

  static List<Measurement> parseMeasureResponse(String responseBody) {
    final parses = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parses
        .map<Measurement>((json) => Measurement.fromJson(json))
        .toList();
  }

  static List<User> parseResponseUser(String responseBody) {
    final parses = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parses.map<User>((json) => User.fromJson(json)).toList();
  }
}
