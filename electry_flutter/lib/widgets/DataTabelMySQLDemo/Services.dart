import 'dart:convert';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Measurement.dart';
import 'package:http/http.dart' as http;
import 'Device.dart';

class Services {
  static const ROOT = 'http://164.138.220.181:3000/devices';
  static const _GET_ALL_ACTION = 'all';
  static const _SEARCH_ACTION = 'search';
  static const _EDIT_ACTION = 'edit';
  static const _DELETE_ACTION = 'delete';
  static const _GET_MEASUREMENTS_ACTION = 'measurements';

  static Future<List<Device>> getDevices() async{
    try{
      var map = Map<String, dynamic>();
      map['sub_api'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Get Table Response: ${response.body}');
      if(200 == response.statusCode){
        List<Device> list = parseResponse(response.body);
        return list;
      }else{
        return List<Device>();  
      }
    }catch (e){
      return List<Device>();
    }
  }

  static Future<List<Device>> searchDevice(int Id) async{
    try{
      var map = Map<String, dynamic>();
      map['sub_api'] = _SEARCH_ACTION;
      map['search'] = Id.toString();
      final response = await http.post(ROOT, body: map);
      print('Get Table Response: ${response.body}');
      if(200 == response.statusCode){
        List<Device> dev = parseResponse(response.body);
        return dev;
      }else{
        return List<Device>();
      }
    }catch (e){
      return List<Device>();
    }
  }

  static Future<List<Measurement>> getMeasurements(int Id) async{
    try{
      var map = Map<String, dynamic>();
      map['sub_api'] = _GET_MEASUREMENTS_ACTION;
      map['id'] = Id.toString();
      final response = await http.post(ROOT, body: map);
      print('Get Table Response: ${response.body}');
      if(200 == response.statusCode){
        print("passing");
        List<Measurement> measure = parseMeasureResponse(response.body);
        return measure;
      }else{
        print("not 200: ${response.statusCode}");
        return [];
      }
    }catch (e){
      print(e);
      return [];
    }
  }

  static updateDevice(int Id, String change, String dev) async{
    try{
      var map = Map<String, dynamic>();
      map['sub_api'] = _EDIT_ACTION;
      map['id'] = Id.toString();
      map['change_set'] = change;
      map['dev_x'] = dev;
      final response = await http.post(ROOT, body: map);
      print('Edit Device Response: ${response.body}');
      if(200 == response.statusCode){
        print("passing");
      }else{
        print("not 200: ${response.statusCode}");
      }
    }catch (e){
      print(e);
    }
  }

  static List<Device> parseResponse(String responseBody){
    final parses = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parses.map<Device>((json) => Device.fromJson(json)).toList();
  }

  static List<Measurement> parseMeasureResponse(String responseBody){
    final parses = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parses.map<Measurement>((json) => Measurement.fromJson(json)).toList();
  }
}

