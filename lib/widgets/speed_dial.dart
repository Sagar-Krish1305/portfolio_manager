import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:portfolio_manager/colors.dart';

class SpeedDialWidget extends StatefulWidget {
  final String currentRoute;
  const SpeedDialWidget({super.key, required this.currentRoute});

  @override
  State<SpeedDialWidget> createState() => _SpeedDialWidgetState();
}

class _SpeedDialWidgetState extends State<SpeedDialWidget> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: kPrimaryCyan,
      overlayColor: Colors.black,
      overlayOpacity: 0.6,
      spacing: 10,
      spaceBetweenChildren: 8,
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.dashboard,
            color: kPrimaryCyan,
          ),
          label: 'Dashboard',
          onTap: () {
            if (widget.currentRoute != '/dashboard') {
              Navigator.pushReplacementNamed(context, '/dashboard');
            }
          },
          labelStyle: const TextStyle(color: kPrimaryCyan),
          backgroundColor: kCardBackground,
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.analytics,
            color: kPrimaryCyan,
          ),
          label: 'Risk Analysis',
          onTap: () {
            if (widget.currentRoute != '/risk_analysis') {
              Navigator.pushReplacementNamed(context, '/risk_analysis');
            }
          },
          labelStyle: const TextStyle(color: kPrimaryCyan),
          backgroundColor: kCardBackground,
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.person,
            color: kPrimaryCyan,
          ),
          label: 'User Profile',
          onTap: () {
            if (widget.currentRoute != '/profile') {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          },
          labelStyle: const TextStyle(color: kPrimaryCyan),
          backgroundColor: kCardBackground,
        ),
      ],
    );
  }
}
