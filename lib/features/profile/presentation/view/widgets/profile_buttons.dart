import 'package:auto_route/auto_route.dart';
import 'package:event_management_system/core/router/app_router.dart';
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
          const SizedBox(height: 10),
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
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: const Center(
                        child: Text(
                      'My Events',
                      textAlign: TextAlign.center,
                    )),
                  );
                },
              )),
          const SizedBox(height: 10),
          WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                  delay: const Duration(milliseconds: 1100),
                  opacity: 0.5,
                  duration: const Duration(milliseconds: 1000)),
              child: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: const Center(
                        child: Text(
                      'Host',
                      textAlign: TextAlign.center,
                    )),
                  );
                },
              )),
          const SizedBox(height: 10),
          WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                  delay: const Duration(milliseconds: 1400),
                  opacity: 0.5,
                  duration: const Duration(milliseconds: 1000)),
              child: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.router.push(const AddEventFormRoute());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: const Center(
                          child: Text(
                        'Add Event',
                        textAlign: TextAlign.center,
                      )),
                    ),
                  );
                },
              )),
          const SizedBox(height: 10),
          WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                  delay: const Duration(milliseconds: 1700),
                  opacity: 0.5,
                  duration: const Duration(milliseconds: 1000)),
              child: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: const Center(
                        child: Text(
                      'Register Host Account',
                      textAlign: TextAlign.center,
                    )),
                  );
                },
              )),
          const SizedBox(height: 10),
          WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                  delay: const Duration(milliseconds: 2000),
                  opacity: 0.5,
                  duration: const Duration(milliseconds: 1000)),
              child: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: const Center(
                        child: Text(
                      'Payment Information',
                      textAlign: TextAlign.center,
                    )),
                  );
                },
              )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
