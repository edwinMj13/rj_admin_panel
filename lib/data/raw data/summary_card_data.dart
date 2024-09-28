import 'package:flutter/material.dart';

import '../models/summary_card_model.dart';

class SummaryCardData{
  final summaryCard=<SummaryCardModel>[
    SummaryCardModel(title: 'Total Orders', icon: Icons.shopping_cart, data: 4037, color: Colors.yellow, backgroundColor: Colors.yellow.shade100),
    SummaryCardModel(title: 'Processing Orders', icon: Icons.travel_explore, data: 4037, color: Colors.blue, backgroundColor: Colors.blue.shade100),
    SummaryCardModel(title: 'Pending Orders', icon: Icons.refresh, data: 4037, color: Colors.orange, backgroundColor: Colors.orange.shade100),
    SummaryCardModel(title: 'Completed Orders', icon: Icons.check, data: 4037, color: Colors.cyan, backgroundColor: Colors.cyan.shade100),
  ];
}