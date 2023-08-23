import 'package:auto_route/auto_route.dart';
import 'package:event_management_system/features/event/presentation/view/widgets/event_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                
                EventWidget(
                  title: 'A Decade of Dreams: 10th Birthday Bash',
                ),
                SizedBox(
                  height: 10,
                ),
                EventWidget(
                    title: 'Celebrating New Life: Baby Shower Delight',
                    backgroundColor: Color.fromARGB(255, 255, 0, 106)),
              ],
            ),
          ),
        ));
  }
}
