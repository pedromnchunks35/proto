import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class FilterType {
  FilterType({
    this.type ="",
    this.id ="",
    this.label ="",
    this.iconCode ="",
    this.code ="",
    this.isSelected = true,



  });

  String type;
  String id;
  String label;
  String iconCode;
  String code;
  bool isSelected;



  factory FilterType.fromJsonAttraction(Map<String, dynamic> json) => FilterType(
    type: "at",
    id: json['id'].toString(),
    label: json['label'],
    iconCode: json['iconCode'].toString(),
    code: json['code'],

  );

  factory FilterType.fromJsonInfra(Map<String, dynamic> json) => FilterType(
      type: "is",
      id: json['id'].toString(),
      label: json['label'],
      iconCode: json['iconCode'].toString(),
      code: json['code'].toString(),


  );

  factory FilterType.fromJsonPOI(Map<String, dynamic> json) => FilterType(
      type: "POI",
      id: json['id'].toString(),
      label: json['label'],
      iconCode: json['iconCode'].toString(),
      code: json['code'],


  );



  Map<String, dynamic> toJson() => {
    'type': type,
    'label': label,
    'iconCode': iconCode,
    'id': id,
    'code': code,



  };


}
class Header{
  //VARS
  String name;
  int id;
  String type;
  //CONSTRUTOR
  Header({required this.name,required this.type,required this.id});
}


