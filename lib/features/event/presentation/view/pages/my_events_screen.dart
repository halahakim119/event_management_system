import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/injection/injection_imports.dart';
import '../../../../../core/router/app_router.dart';
import '../widgets/my_events_widget.dart';

@RoutePage()
class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  _MyEventsScreenState createState() => _MyEventsScreenState();
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
  BlocListener<EventCubit, EventState>? eventCubitListener;

  @override
  void initState() {
    super.initState();

    // Initialize the listener
    eventCubitListener = BlocListener<EventCubit, EventState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));
          },
          created: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));
            context.read<UserBloc>().add(GetUserEvent(user!.id!));
          },
          deleted: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));
            context.read<UserBloc>().add(GetUserEvent(user!.id!));
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                context.router.push(const DraftListRoute());
              },
              label:const  Text('EVENT'),
              icon:const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: const Text('events'),
            ),
            body: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserError) {
                  return Center(child: Text(state.message));
                } else if (state is UserLoaded) {
                  return MyEventsWidget(
                    isArabic: isArabic,
                    user: state.user,
                  );
                } else {
                  return const Center(child: Text('unknown'));
                }
              },
            ),
          );
        },
      ),
    );

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  bool get isArabic => context.locale.languageCode == 'ar';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final themeCubit = sl<ThemeCubit>();
            themeCubit.loadThemeMode();
            return themeCubit;
          },
        ),
        BlocProvider(
          create: (context) => sl<UserBloc>()..add(GetUserEvent(user!.id!)),
        ),
        BlocProvider(
          create: (context) => sl<EventCubit>(),
        ),
      ],
      child: eventCubitListener!,
    );
  }
}
