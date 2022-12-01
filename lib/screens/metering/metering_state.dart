import 'package:lightmeter/models/exposure_pair.dart';
import 'package:lightmeter/models/photography_value.dart';

class MeteringState {
  final double ev;
  final double evCompensation;
  final IsoValue iso;
  final double nd;
  final List<ExposurePair> exposurePairs;

  const MeteringState({
    required this.ev,
    required this.evCompensation,
    required this.iso,
    required this.nd,
    required this.exposurePairs,
  });

  ExposurePair? get fastest => exposurePairs.isEmpty ? null : exposurePairs.first;
  ExposurePair? get slowest => exposurePairs.isEmpty ? null : exposurePairs.last;
}
