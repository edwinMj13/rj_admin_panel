import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
import '../../utils/constants.dart';
import '../providers/category_provider.dart';

class ChipsWidget extends StatelessWidget {
  final List<String> value;
  const ChipsWidget({super.key,required this.value, });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
          spacing: 5,
          children: value.isEmpty
              ? List.generate(1, (i) => const SizedBox())
              : List.generate(value.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
              child: Chip(
                label: Text(value[index]),
                labelStyle: const TextStyle(color: secondaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.red.shade100),
                ),
                backgroundColor: Colors.red.shade100,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                deleteIconColor: Colors.red,
                shadowColor: backgroundColor,
                surfaceTintColor: Colors.grey,
                onDeleted: () {
                  context.read<CategoryProvider>().deleteSubCtaegory(index);
                },
              ),
            );
          })),
    );
  }
}
