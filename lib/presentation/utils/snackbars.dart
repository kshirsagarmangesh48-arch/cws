import 'package:flutter/material.dart';
import '../../app.dart';


List<OverlayEntry> overlayEntries = [];
OverlayEntry? _loaderEntry;


void showCustomSnackbar(String message, Color borderColor) {


  final overlay = overlayKey.currentState;

  final overlayEntry = OverlayEntry(
    builder: (context) {
      // Calculate position based on existing entries count
      double? topOffset = (16 + overlayEntries.length * 40);
      double? bottomOffset;
      double? rightOffset = 16;
      double? leftOffset = 100;

      return Positioned(
        top: topOffset,
        right: rightOffset,
        bottom: bottomOffset,
        left: leftOffset,
        child: Material(
          color: Theme.of(context).colorScheme.onPrimary,
          child: SnackbarContent(
            message: message,
            borderColor: borderColor,
          ),
        ),
      );
    },
  );

  overlayEntries.add(overlayEntry);
  overlay?.insert(overlayEntry);

  // Remove the overlay after a duration
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
    overlayEntries.remove(overlayEntry);
  });
}



void showSuccessSnackbar(String message) {
  showCustomSnackbar(message, Colors.green);
}

void showFailureSnackbar(String message) {
  showCustomSnackbar(message, Colors.red);
}

class SnackbarContent extends StatelessWidget {
  final String message;
  final Color borderColor;

  const SnackbarContent({
    super.key,
    required this.message,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [borderColor, borderColor.withGreen(100)], // Gradient background
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(3, 3), // More pronounced shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Spacious padding
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Colors.white, // White text for contrast against the gradient
          fontWeight: FontWeight.bold, // Bold text for emphasis
          fontSize: 12, // Larger text size for better readability
          letterSpacing: 1.0, // Increased spacing for a modern feel
        ),
        textAlign: TextAlign.center, // Centered text
      ),
    );
  }
}

void showLoader(String message) {
  final overlay = overlayKey.currentState;
  if (_loaderEntry == null) {
    _loaderEntry = OverlayEntry(
      builder: (context) => FullScreenLoader(message: message),
    );

    overlay?.insert(_loaderEntry!);
  }
}

void hideLoader() {
  _loaderEntry?.remove();
  _loaderEntry = null;
}



class FullScreenLoader extends StatelessWidget {
  final String message;

  const FullScreenLoader({super.key, this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}