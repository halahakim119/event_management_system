import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../theme/presentation/theme_cubit.dart';
import '../../../../user/data/models/user_model.dart';
import '../../../domain/entities/event_entity.dart';
import '../../logic/cubit/request_cubit.dart';
import '../widgets/event_card_body.dart';
import '../widgets/event_card_footer.dart';
import '../widgets/event_card_header.dart';

@RoutePage()
class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  void _onBoxChange() {
    if (mounted) {
      setState(() {
        getUserData();
      });
    }
  }

  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  @override
  void initState() {
    super.initState();

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if the current locale is English ('en')
    bool isArabic = context.locale.languageCode == 'ar';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            // Initialize ThemeCubit and load the saved theme mode
            final themeCubit = sl<ThemeCubit>();
            themeCubit.loadThemeMode();
            return themeCubit;
          },
        ),
        BlocProvider(
          create: (context) => sl<RequestCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return Scaffold(
              appBar: AppBar(),
              body: BlocConsumer<RequestCubit, RequestState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (userBox.isEmpty || user == null) {
                    return const Center(
                      child: Text('You are not logged in.'),
                    );
                  }
                  if (user?.events == null) {
                    return const Center(
                      child: Text('No events available'),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 0.3,
                        endIndent: 15,
                        indent: 15,
                      );
                    },
                    itemCount: user!.events!.length,
                    itemBuilder: (context, index) {
                      EventEntity event = user!.events![index];

                      return Column(
                        children: [
                          EventCardHeader(isArabic: isArabic, event: event),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                              borderRadius: BorderRadius.only(
                                  topRight: isArabic == false
                                      ? Radius.zero
                                      : const Radius.circular(15),
                                  topLeft: isArabic == true
                                      ? Radius.zero
                                      : const Radius.circular(15),
                                  bottomLeft: const Radius.circular(15),
                                  bottomRight: const Radius.circular(15)),
                            ),
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.only(
                                bottom: 15, right: 15, left: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  EventCardBody(
                                      event: event, isArabic: isArabic),
                                  EventCardFooter(
                                    event: event,
                                    isArabic: isArabic,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ));
        },
      ),
    );
  }
}
