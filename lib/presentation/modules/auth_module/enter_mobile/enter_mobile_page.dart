import 'package:cws/infrastructure/theme/colors.dart';
import 'package:cws/presentation/utils/common_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EnterMobilePage extends StatefulWidget {
  const EnterMobilePage({super.key});

  @override
  State<EnterMobilePage> createState() => _EnterMobilePageState();
}

class _EnterMobilePageState extends State<EnterMobilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final CarouselSliderController _carouselController = CarouselSliderController();

  int _currentIndex = 0;

  final List<String> _sliderImages = [
    'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
    'https://cdn-icons-png.flaticon.com/512/3256/3256013.png',
    'https://cdn-icons-png.flaticon.com/512/3063/3063829.png',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      // TODO: Navigate to OTP screen
    }
  }

  void _onTermsTapped() {
    // TODO: Navigate to Terms page
  }

  void _onPrivacyTapped() {
    // TODO: Navigate to Privacy page
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: _sliderImages.length,
                  itemBuilder: (context, index, realIdx) {
                    return Container(
                      width: size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(_sliderImages[index]),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: size.height * 0.25,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() => _currentIndex = index);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _sliderImages.asMap().entries.map((entry) {
                    final isActive = _currentIndex == entry.key;
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isActive ? 24 : 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? CWSColors.blueButtonColor
                              : Colors.grey[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Text(
                  'Enter Your Mobile Number',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'We’ll send a one-time password (OTP) to verify your number.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: '9552006353',
                      prefixText: '+91  ',
                      prefixStyle: TextStyle(
                        color: CWSColors.blueButtonColor,
                        fontWeight: FontWeight.w600,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 10) {
                        return 'Please enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CommonButton(
                    onPressed: _onContinue,
                    loading: false,
                    text: "Continue",
                    textColor: Colors.white,
                    color: CWSColors.blueButtonColor,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _onTermsTapped,
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _onPrivacyTapped,
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
