import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../theme/presentation/theme_cubit.dart';
import '../../../domain/entities/event_entity.dart';
import '../../logic/cubit/init_cubit.dart';
import '../widgets/event_card_body.dart';
import '../widgets/event_card_footer.dart';
import '../widgets/event_card_header.dart';

@RoutePage()
class DraftsScreen extends StatefulWidget {
  const DraftsScreen({super.key});

  @override
  State<DraftsScreen> createState() => _DraftsScreenState();
}

class _DraftsScreenState extends State<DraftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => sl<InitCubit>()..getAllInit(),
        child: BlocBuilder<InitCubit, InitState>(
          builder: (context, state) {
            return state.maybeWhen(
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
          
                loaded: (events) => drafts(events: events),
                error: (failure) => Center(
                      child: Text(failure),
                    ),
                orElse: () => Text('unkown'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.router.push(const AddEventFormRoute());
        },
      ),
    );
  }
}

class drafts extends StatelessWidget {
  List<EventEntity>? events;
  drafts({
    required this.events,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    return BlocProvider(
      create: (context) {
        // Initialize ThemeCubit and load the saved theme mode
        final themeCubit = sl<ThemeCubit>();
        themeCubit.loadThemeMode();
        return themeCubit;
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 0.3,
                endIndent: 15,
                indent: 15,
              );
            },
            itemCount: events?.length ?? 0,
            itemBuilder: (context, index) {
              EventEntity event = events![index];

              return Column(
                children: [
                  EventCardHeader(isArabic: isArabic, event: event),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
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
                    margin:
                        const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          EventCardBody(event: event, isArabic: isArabic),
                          EventCardFooter(event: event, isArabic: isArabic),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
