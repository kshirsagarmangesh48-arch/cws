import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAssetImage extends StatefulWidget {
  final String lottieAssetPath;
  final double? width;
  final double? height;

  const LottieAssetImage(
      {super.key, required this.lottieAssetPath, this.width, this.height});

  @override
  State<LottieAssetImage> createState() => _LottieAssetImageState();
}

class _LottieAssetImageState extends State<LottieAssetImage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        widget.lottieAssetPath, // Path to your Lottie JSON file in assets
        width: widget.width ?? 200,
        height: widget.height ?? 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
