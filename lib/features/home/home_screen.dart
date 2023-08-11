import 'package:auto_route/auto_route.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../search and filter/search_screen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key); // Adjusted the super constructor call here

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> { // Corrected the state type here
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Hero(
          tag: 'searchIcon',
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                CircularClipRoute<void>(
                  builder: (_) => SearchScreen(),
                  expandFrom: context,
                ),
              );
            },
          ),
        ),
      ),
      body: Center(child: Text('Choose a color using the button below.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.color_lens),
        backgroundColor: currentColor,
      ),
    );
  }
}
