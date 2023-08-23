// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class EventWidget extends StatelessWidget {
  final Color? backgroundColor;
  final String title;

  const EventWidget({
    Key? key,
    this.backgroundColor,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: backgroundColor != null
                        ? [
                            [
                              backgroundColor?.withOpacity(0.5) ??
                                  Colors.transparent,
                              backgroundColor?.withOpacity(0) ??
                                  Colors.transparent,
                            ],
                            [
                              backgroundColor?.withOpacity(0.6) ??
                                  Colors.transparent,
                              backgroundColor?.withOpacity(0) ??
                                  Colors.transparent,
                            ],
                            [
                              backgroundColor ?? Colors.transparent,
                              backgroundColor?.withOpacity(0.5) ??
                                  Colors.transparent,
                            ],
                          ]
                        : [
                            [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                            [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                            [
                              Theme.of(context).primaryColor,
                              Colors.transparent,
                            ],
                          ],
                    durations: backgroundColor != null
                        ? [5000, 4000, 3000]
                        : [0, 0, 3000],
                    heightPercentages: backgroundColor != null
                        ? [0.20, 0.4, 0.6]
                        : [0, 0, 0.75],
                    blur: const MaskFilter.blur(BlurStyle.solid, 10),
                  ),
                  waveAmplitude: 0,
                  backgroundColor:
                      Theme.of(context).colorScheme.onInverseSurface,
                  size: const Size(double.infinity, double.infinity),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(title.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Food',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'No children allowed',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'No alcohol',
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onInverseSurface,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  'baghdad',
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onInverseSurface,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '2023-22-32\n2023-22-82',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Container(
                            height: 105,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              '4:30 am\n-\n9:00 pm',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).disabledColor),
                          onPressed: () {},
                          child: const Text('Edit Invitations')),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).disabledColor),
                          onPressed: () {},
                          child: const Text('Edit Hosting'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
