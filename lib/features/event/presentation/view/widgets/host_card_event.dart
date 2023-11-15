import 'package:flutter/material.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../host/domain/entities/host_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class HostCardEvent extends StatelessWidget {
  HostEntity host;
  bool isArabic;
  String? message;
  final EventStatus? currentEventStatus;

  HostCardEvent(
      {Key? key,
      required this.host,
      required this.isArabic,
      this.currentEventStatus,
      this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return message != null
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            margin: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context)
                        .style, // TextStyle by default
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Host Name: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: host.name ?? 'unknown',
                        style: TextStyle(
                            fontWeight: FontWeight
                                .normal), // Set the style you want for the host's name
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context)
                        .style, // TextStyle by default
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Message: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: message ?? 'unknown',
                        style: TextStyle(
                            fontWeight: FontWeight
                                .normal), // Set the style you want for the host's name
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              margin: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context)
                          .style, // TextStyle by default
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Host Name: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: host.name ?? 'unknown',
                          style: TextStyle(
                              fontWeight: FontWeight
                                  .normal), // Set the style you want for the host's name
                        ),
                      ],
                    ),
                  ),
                  host.locationDescription != null
                      ? RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context)
                                .style, // TextStyle by default
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Location: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: host.locationDescription,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .normal), // Set the style you want for the host's name
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  host.locationLink != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    Theme.of(context).disabledColor),
                            onPressed: () {
                              // Replace the URL with your Google Maps link
                              String googleMapsUrl = host.locationLink!;

                              // Check if the URL can be launched
                              canLaunch(googleMapsUrl).then((canLaunch) {
                                if (canLaunch) {
                                  // Launch the URL
                                  launch(googleMapsUrl);
                                } else {
                                  // Handle the error or show a message
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('Could not launch Google Maps'),
                                  ));
                                }
                              });
                            },
                            child: const Text('Open Google Maps'),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
  }
}
