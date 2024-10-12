import 'package:flutter/material.dart';

class TextLimitedHundredWidget extends StatelessWidget {
  const TextLimitedHundredWidget({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: name,
      child: Center(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 50,
              maxWidth: 100,
            ),
            child: Center(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )),
    );
  }
}
