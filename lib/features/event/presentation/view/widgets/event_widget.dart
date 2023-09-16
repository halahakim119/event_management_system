import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../../../core/router/app_router.dart';

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
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '4:30 am',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '9:00 pm',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Text(
                  'Baghdad',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                            gradients: backgroundColor == null
                                ? [
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
                                  ]
                                : [
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
                                  ],
                            durations: backgroundColor == null
                                ? [0, 0, 3000]
                                : [5000, 4000, 3000],
                            heightPercentages: backgroundColor == null
                                ? [0, 0, 0.75]
                                : [0.20, 0.4, 0.6],
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
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(title.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check,
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
                                        Icons.check,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'children allowed',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'alcohol',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).disabledColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      '2023-22-32',
                                    ),
                                    Text(
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      '2023-22-82',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).disabledColor),
                                  onPressed: () {
                                    context.router
                                        .push(const InvitationRoute());
                                  },
                                  child: const Text(
                                    'Invitations',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).disabledColor),
                                  onPressed: () {
                                    context.router
                                        .push(const FilterHostsRoute());
                                  },
                                  child: const Text(
                                    'Host',
                                    style: TextStyle(color: Colors.white),
                                  ))
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
    );
  }
}

// void main() => runApp(WaveDemoApp());

// final String appName = 'Demo WAVE';

// class WaveDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: appName,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         useMaterial3: true,
//       ),
//       home: WaveDemoHomePage(title: appName),
//     );
//   }
// }

// class WaveDemoHomePage extends StatefulWidget {
//   WaveDemoHomePage({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _WaveDemoHomePageState createState() => _WaveDemoHomePageState();
// }

// class _WaveDemoHomePageState extends State<WaveDemoHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 eventCard(
//                     event: EventEntity(
//                         dressCode: 'FFF',
//                         endingDate: DateTime.now(),
//                         endsAt: DateTime.now(),
//                         food: true,
//                         guestsNumber: 33,
//                         startingDate: DateTime.now(),
//                         id: '',
//                         startsAt: DateTime.now(),
//                         type: '',
//                         guests: [],
//                         title: 'jhh',
//                         plannerId: '',
//                         postType: '',
//                         adultsOnly: true,
//                         alcohol: true,
//                         description: 'uhfsdi')),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class eventCard extends StatelessWidget {
//   EventEntity event;

//   eventCard({
//     Key? key,
//     required this.event,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IntrinsicHeight(
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.onInverseSurface,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             padding: const EdgeInsets.all(10.0),
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   event.startsAt.toString(),
//                   style: const TextStyle(fontSize: 14),
//                 ),
//                 Text(
//                   event.startsAt.toString(),
//                   style: const TextStyle(fontSize: 14),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Baghdad',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SizedBox(
//               height: 260,
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     bottom: 0,
//                     child: _buildCard(
//                         backgroundColor: Colors.purpleAccent, context: context),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   _buildCard({Color? backgroundColor, context}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.onInverseSurface,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       height: 80,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: WaveWidget(
//           config: CustomConfig(
//             gradients: backgroundColor == null
//                 ? [
//                     [
//                       Colors.transparent,
//                       Colors.transparent,
//                     ],
//                     [
//                       Colors.transparent,
//                       Colors.transparent,
//                     ],
//                     [
//                       Theme.of(context).primaryColor,
//                       Colors.transparent,
//                     ],
//                   ]
//                 : [
//                     [
//                       backgroundColor.withOpacity(0.5),
//                       backgroundColor.withOpacity(0),
//                     ],
//                     [
//                       backgroundColor.withOpacity(0.6),
//                       backgroundColor.withOpacity(0),
//                     ],
//                     [
//                       backgroundColor,
//                       backgroundColor.withOpacity(0.5),
//                     ],
//                   ],
//             durations:
//                 backgroundColor == null ? [0, 0, 3000] : [5000, 4000, 3000],
//             heightPercentages:
//                 backgroundColor == null ? [0, 0, 0.75] : [0.20, 0.4, 0.6],
//             blur: const MaskFilter.blur(BlurStyle.solid, 10),
//           ),
//           waveAmplitude: 0,
//           backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
//           size: const Size(double.infinity, double.infinity),
//         ),
//       ),
//     );
//   }
// }
