
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Color? color;
  final Widget? image;
  final String? text;
  final double? spacing;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback onPressed;
  final bool loading;
  final Color? textColor;

  const CommonButton({super.key,
    this.color,
    this.image,
    this.text,
    this.spacing = 2.0,
    this.borderColor,
    this.borderWidth = 1.0,
    required this.onPressed,
    required this.loading,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = color ?? Theme.of(context).colorScheme.onPrimary;


    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero, // Ensure button takes whole width
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1.0,
          ),
        ),
      ),
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {

    if (loading) {
      return const SizedBox(// Take full width
        height: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else if (image != null && text != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            image!,
            SizedBox(width: spacing ?? 2.0),
            Expanded(
              child: Text(
                text!,
                textAlign: TextAlign.center, // Center align text
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor?? Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      );
    } else if (image != null) {
      return image!;
    } else if (text != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text!,
          textAlign: TextAlign.center, // Center align text
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
        ),
      );
    } else {
      return const SizedBox.shrink(); // Return an empty widget if both image and text are null
    }
  }
}
