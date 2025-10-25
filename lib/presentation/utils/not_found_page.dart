import 'package:cws/infrastructure/theme/colors.dart';
import 'package:cws/infrastructure/utils/image_paths.dart';
import 'package:cws/presentation/utils/lottie_asset_image.dart';
import 'package:flutter/material.dart';

import 'common_button.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            LottieAssetImage(lottieAssetPath: ImagePaths.carWash),
            Text(
              'No Data Found',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CommonButton(
          onPressed: () {},
          color: CWSColors.blueButtonColor,
          text: 'Continue',
          textColor: Colors.white,
          loading: false,
        ),
      ),
    );
  }
}
