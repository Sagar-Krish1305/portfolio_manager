import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(top: 80, bottom: 20),
      decoration: const BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: const Icon(Icons.person, size: 80,
      )
      );
  }
}