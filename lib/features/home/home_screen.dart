import 'package:auto_route/auto_route.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../search and filter/search_screen.dart';
import '../theme/presentation/theme_cubit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
                  builder: (_) => SearchScreen(),
                  expandFrom: context,
                ),
              );
            },
          ),
        ),
      ),
      body: Center()
    );
  }
}
