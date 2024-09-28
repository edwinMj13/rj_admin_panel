import 'package:flutter/material.dart';

class SideBarModel{
  final String title;
  final IconData icon;
  List<String>? subSections;

  SideBarModel({required this.title, required this.icon,this.subSections,});

}