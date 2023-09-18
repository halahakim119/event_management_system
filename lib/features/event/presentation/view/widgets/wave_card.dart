import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveCard extends StatelessWidget {
  const WaveCard({
    super.key,
    required this.backgroundColor,
    required this.context,
  });

  final Color? backgroundColor;
  final context;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
                      backgroundColor!.withOpacity(0.5),
                      backgroundColor!.withOpacity(0),
                    ],
                    [
                      backgroundColor!.withOpacity(0.6),
                      backgroundColor!.withOpacity(0),
                    ],
                    [
                      backgroundColor!,
                      backgroundColor!.withOpacity(0.5),
                    ],
                  ],
            durations:
                backgroundColor == null ? [0, 0, 3000] : [5000, 4000, 3000],
            heightPercentages:
                backgroundColor == null ? [0, 0, 0.75] : [0.20, 0.4, 0.6],
            blur: const MaskFilter.blur(BlurStyle.solid, 10),
          ),
          waveAmplitude: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          size: const Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}
