import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../../theme/presentation/theme_cubit.dart';

class ProfileBody extends StatelessWidget {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                  delay: const Duration(milliseconds: 500),
                  opacity: 0.5,
                  duration: const Duration(milliseconds: 1000)),
              child: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Center(
                        child: Text(
                      'My Events',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background),
                    )),
                  );
                },
              )),
        ],
      ),
    );
  }
}
