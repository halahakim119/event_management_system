import 'package:auto_route/auto_route.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/material.dart';

import '../search and filter/search_screen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key})
      : super(key: key); // Adjusted the super constructor call here

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  builder: (_) => const SearchScreen(),
                  expandFrom: context,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
