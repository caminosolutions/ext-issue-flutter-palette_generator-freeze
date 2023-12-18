import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageIsBlackWidget extends StatefulWidget {
  final ImageProvider imageProvider;
  final Widget Function(bool isBlack) builder;

  const ImageIsBlackWidget({
    super.key,
    required this.imageProvider,
    required this.builder,
  });

  @override
  State<ImageIsBlackWidget> createState() => _ImageIsBlackWidgetState();
}

class _ImageIsBlackWidgetState extends State<ImageIsBlackWidget> {
  bool _loading = true;
  bool? _isBlack;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      // Let's test if the loader appears.
      const Duration(milliseconds: 1000),
      () => _isImageBlack(widget.imageProvider).then((isBlack) {
        _isBlack = isBlack;
        _loading = false;
        setState(() {});
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox(
        width: 200,
        height: 200,
        child: RepaintBoundary(child: CircularProgressIndicator()),
      );
    }
    return widget.builder(_isBlack ?? false);
  }

  Future<bool> _isImageBlack(ImageProvider image) async {
    const double threshold = 0.35; //<-- play around with different images and set appropriate threshold
    final double imageLuminance = await _getAvgLuminance(image);
    return imageLuminance < threshold;
  }

  Future<double> _getAvgLuminance(ImageProvider image) async {
    final List<Color> colors = (await PaletteGenerator.fromImageProvider(
      image,
      // size: const Size(256.0, 170.0),
      // maximumColorCount: 20,
    ))
        .colors
        .toList(growable: false);
    double totalLuminance = 0;
    colors.forEach((color) => totalLuminance += color.computeLuminance());
    return totalLuminance / colors.length;
  }
}
