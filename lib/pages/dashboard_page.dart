import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/widgets/holdings_widget.dart';
import 'package:portfolio_manager/widgets/portfolio_summary_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PortfolioSummaryWidget(),
                SizedBox(height: 16),
                HoldingsWidget(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: kPrimaryCyan,
        overlayColor: Colors.black,
        overlayOpacity: 0.6,
        spacing: 10,
        spaceBetweenChildren: 8,

        children: [
          SpeedDialChild(
            child: const Icon(Icons.dashboard, color: kPrimaryCyan,),
            label: 'Dashboard',
            onTap: () {
              if(currentRoute != '/dashboard'){
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
            },
            labelStyle: const TextStyle(
              color: kPrimaryCyan
            ),
            backgroundColor: kCardBackground,
          ),
          SpeedDialChild(
            child: const Icon(Icons.analytics, color: kPrimaryCyan,),
            label: 'Risk Analysis',
            onTap: () {
              if(currentRoute != '/risk') {
                Navigator.pushReplacementNamed(context, '/risk');
              }
            },
            labelStyle: const TextStyle(
              color: kPrimaryCyan
            ),
            backgroundColor: kCardBackground,
          ),
          SpeedDialChild(
            child: const Icon(Icons.person, color: kPrimaryCyan,),
            label: 'User Profile',
            onTap: () {
              if(currentRoute != '/profile') {
                Navigator.pushReplacementNamed(context, '/profile');
              }
            },
            labelStyle: const TextStyle(
              color: kPrimaryCyan
            ),
            backgroundColor: kCardBackground,
          ),
        ],
      ),
    );
  }
}
