import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../theme/presentation/theme_cubit.dart';

@RoutePage()
class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Initialize ThemeCubit and load the saved theme mode
        final themeCubit = sl<ThemeCubit>();
        themeCubit.loadThemeMode();
        return themeCubit;
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            // app theme
            theme: themeMode == ThemeMode.light
                ? AppTheme.themeData
                : AppTheme.darkTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            home: Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        _buildCardInfo(
                            title: 'A Decade of Dreams: 10th Birthday Bash',
                            context: context),
                        const SizedBox(
                          height: 10,
                        ),
                        // _buildCard(
                        //     title: 'ss',
                        //     backgroundColor: Color.fromARGB(255, 83, 0, 161),
                        //     context: context),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // _buildCard(
                        //     title: 'ss',
                        //     backgroundColor: Colors.amber,
                        //     context: context)
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  _buildwave({Color? backgroundColor, context}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 80,
      width: double.infinity,
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
                      backgroundColor.withOpacity(0.5),
                      backgroundColor.withOpacity(0),
                    ],
                    [
                      backgroundColor.withOpacity(0.6),
                      backgroundColor.withOpacity(0),
                    ],
                    [
                      backgroundColor,
                      backgroundColor.withOpacity(0.5),
                    ],
                  ],
            durations:
                backgroundColor == null ? [0, 0, 3000] : [5000, 4000, 3000],
            heightPercentages:
                backgroundColor == null ? [0, 0, 0.75] : [0.20, 0.4, 0.6],
            blur: const MaskFilter.blur(BlurStyle.solid, 10),
          ),
          waveAmplitude: 0,
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          size: const Size(double.infinity, double.infinity),
        ),
      ),
    );
  }

  _buildCardInfo({Color? backgroundColor, context, required String title}) {
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
                      child: _buildwave(
                          backgroundColor: backgroundColor, context: context)),
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
                                  onPressed: () {},
                                  child: const Text(
                                    'Invitations',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).disabledColor),
                                  onPressed: () {},
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

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await init();
//   runApp(
//     MyEventsScreen(),
//   );
// }

