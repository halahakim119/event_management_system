import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/modules/dependency_injection.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../event/domain/entities/event_entity.dart';
import '../../../../event/presentation/view/widgets/check_boxes_card.dart';
import '../../../../event/presentation/view/widgets/wave_card.dart';
import '../../../application/draft_bloc/draft_bloc.dart';
import '../../../domain/entities/draft/draft.dart';

class DraftTile extends StatefulWidget {
  const DraftTile({
    super.key,
    required this.draft,
  });
  final Draft draft;

  @override
  State<DraftTile> createState() => _DraftTileState();
}

class _DraftTileState extends State<DraftTile> {
  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat.Hm().format(dateTime);
    return formattedTime;
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    String? waveColor = widget.draft.dressCode;
    Color? color;
    if (waveColor != null) {
      var colorString = waveColor.replaceAll("Color(", "").replaceAll(")", "");

      if (colorString.startsWith('0x')) {
        // Remove '0x' to get the hexadecimal color string
        String hexColor = colorString.substring(2);

        // Parse the hexadecimal color string to a Color object
        color = Color(int.parse(hexColor, radix: 16));
      }
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 15, right: isArabic ? 35 : 15, left: isArabic ? 15 : 35),
              child: Text(
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  widget.draft.type == null
                      ? "no type"
                      : widget.draft.type!.toUpperCase()),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              // padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        context.router
                            .push(EditDraftRoute(draft: widget.draft));
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Theme.of(context).primaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                title: const Text(
                                    textAlign: TextAlign.center,
                                    'Are you sure you want to delete draft?'),
                                content: const Text(
                                    'delete will remove all data entered'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
                                  ),
                                  BlocProvider(
                                    create: (context) => getIt.get<DraftBloc>(),
                                    child: BlocBuilder<DraftBloc, DraftState>(
                                      builder: (context, state) {
                                        return TextButton(
                                          onPressed: () {
                                            context.read<DraftBloc>().add(
                                                  DraftDeleteRequested(
                                                      id: widget.draft.id!),
                                                );
                                            context.router.pop();
                                          },
                                          child: const Text('Yes'),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Theme.of(context).colorScheme.error,
                      )),
                ],
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.only(
                topRight:
                    isArabic == false ? Radius.zero : const Radius.circular(15),
                topLeft:
                    isArabic == true ? Radius.zero : const Radius.circular(15),
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15)),
          ),
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 260,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(
                          right: isArabic ? 0 : 5,
                          left: isArabic ? 5 : 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              formatTime(widget.draft.startsAt!),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'To',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              formatTime(widget.draft.endsAt!),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                bottom: 0,
                                child: WaveCard(
                                  context: context,
                                  backgroundColor: color,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          widget.draft.title?.toUpperCase() ??
                                              'No title',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      CheckBoxesCard(
                                        food: widget.draft.food,
                                        adultsOnly: widget.draft.adultsOnly,
                                        alcohol: widget.draft.alcohol,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).disabledColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              formatDate(
                                                  widget.draft.startingDate!),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              formatDate(
                                                  widget.draft.endingDate!),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .disabledColor,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('Guests'),
                                                        IconButton(
                                                          onPressed: () {
                                                            context.router
                                                                .pop();
                                                          },
                                                          icon: Icon(Icons
                                                              .cancel_outlined),
                                                        ),
                                                      ],
                                                    ),
                                                    titlePadding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            right: 10,
                                                            top: 15),
                                                    scrollable: true,
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: widget
                                                          .draft.guestsNumbers!
                                                          .map((user) {
                                                        return ListTile(
                                                          leading: CircleAvatar(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                            child: Icon(
                                                              Icons
                                                                  .person_2_rounded,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                            ),
                                                          ),
                                                          title: Text(
                                                              user.name ??
                                                                  "undefined"),
                                                          subtitle: Text(
                                                            user.phoneNumber ??
                                                                "undefined",
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text(
                                              'Invitations',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .disabledColor,
                                            ),
                                            onPressed: () {
                                              List<String>? numbers = widget
                                                  .draft.guestsNumbers
                                                  ?.map((guest) =>
                                                      guest.phoneNumber!)
                                                  .toList();

                                              EventEntity event = EventEntity(
                                                adultsOnly:
                                                    widget.draft.adultsOnly,
                                                alcohol: widget.draft.alcohol,
                                                description:
                                                    widget.draft.description,
                                                dressCode:
                                                    widget.draft.dressCode,
                                                endingDate:
                                                    widget.draft.endingDate,
                                                endsAt: widget.draft.endsAt,
                                       
                                                food: widget.draft.food,
                                                guestsNumber:
                                                    widget.draft.guestsNumber,
                                                guestsNumbers: numbers,
                                                postType: widget.draft.postType,
                                                startingDate:
                                                    widget.draft.startingDate,
                                                startsAt: widget.draft.startsAt,
                                                title: widget.draft.title,
                                                type: widget.draft.type,
                                              );
                                              context.router.push(
                                                  FilterHostsRoute(
                                                      event: event));
                                            },
                                            child: const Text(
                                              'Host',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "POST : ${widget.draft.postType == null ? "" : widget.draft.postType!.toUpperCase()}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "SEAT NO. : ${widget.draft.guestsNumber == null ? "" : widget.draft.guestsNumber.toString()}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            isArabic
                                ? TextSpan(
                                    text: widget.draft.description ?? "",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                    ),
                                  )
                                : TextSpan(
                                    text: 'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .fontSize,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                    ),
                                  ),
                            const TextSpan(text: "  "),
                            !isArabic
                                ? TextSpan(
                                    text: widget.draft.description ?? "",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                    ),
                                  )
                                : TextSpan(
                                    text: 'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .fontSize,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
