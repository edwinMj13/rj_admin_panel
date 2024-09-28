import 'package:flutter/material.dart';

class SummaryCardModel{
  final String title;
  final IconData icon;
  final int data;
  final Color color;
  final Color? backgroundColor;
  SummaryCardModel( {required this.title, required this.icon, required this.data,required this.color,required this.backgroundColor,});
}