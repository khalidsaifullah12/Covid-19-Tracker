import 'dart:convert';

import 'package:covid/Utilities.dart';
import 'package:http/http.dart'as http;

import '../Model/GetWorldData.dart';

class GetCovidData{
   Future<GetWorldData> getworldData()async{
      final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
      if (response.statusCode==200) {
         var data = jsonDecode(response.body.toString());
      return GetWorldData.fromJson(data);
      } else {
     throw Exception("ERROR");
      }
   }




   Future<List<dynamic>> getcuntrieData()async{
     var data;
     final response = await http.get(Uri.parse(AppUrl.countriesList));
     if (response.statusCode==200) {
       data = jsonDecode(response.body.toString());
       return data;
     } else {
       throw Exception("ERROR");
     }
   }

}