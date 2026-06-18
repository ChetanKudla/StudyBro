import 'package:flutter/material.dart';

class NeoBrutalism {
  // Brand Colors
  static const Color primaryPurple = Color(0xFF7F3DFF);
  static const Color lightPurple = Color(0xFFE8DDFF);
  static const Color background = Color(0xFFF9F9F9);
  static const Color pureWhite = Colors.white;
  static const Color darkBlack = Color(0xFF1A1A1A);
  
  // Neon Accent Colors
  static const Color accentYellow = Color(0xFFFFDE43);
  static const Color accentOrange = Color(0xFFFF7A00);
  static const Color accentMint = Color(0xFF38E54D);
  static const Color accentBlue = Color(0xFF33B5E5);

  // Border and Shadow Properties
  static const double borderWidth = 3.0;
  static const double borderRadius = 12.0;
  static const double sharpBorderRadius = 4.0;

  static BoxBorder border({Color color = darkBlack}) {
    return Border.all(
      color: color,
      width: borderWidth,
    );
  }

  static List<BoxShadow> shadows({Color color = darkBlack, double offset = 4.0}) {
    return [
      BoxShadow(
        color: color,
        offset: Offset(offset, offset),
        blurRadius: 0,
      )
    ];
  }
}

// Reusable Custom Neo-Brutalist Widgets to make development consistent
class BrutalContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double padding;
  final double margin;
  final double borderRadius;
  final double shadowOffset;
  final Color shadowColor;
  final double? width;
  final double? height;

  const BrutalContainer({
    super.key,
    required this.child,
    this.backgroundColor = NeoBrutalism.pureWhite,
    this.padding = 16.0,
    this.margin = 0.0,
    this.borderRadius = NeoBrutalism.borderRadius,
    this.shadowOffset = 4.0,
    this.shadowColor = NeoBrutalism.darkBlack,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: NeoBrutalism.border(),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: NeoBrutalism.shadows(color: shadowColor, offset: shadowOffset),
      ),
      child: child,
    );
  }
}

class BrutalButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double shadowOffset;

  const BrutalButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = NeoBrutalism.primaryPurple,
    this.shadowOffset = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: BrutalContainer(
        backgroundColor: backgroundColor,
        padding: 12.0,
        shadowOffset: shadowOffset,
        child: child,
      ),
    );
  }
}

class BrutalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const BrutalTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
            color: NeoBrutalism.darkBlack,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: NeoBrutalism.pureWhite,
            border: NeoBrutalism.border(),
            borderRadius: BorderRadius.circular(NeoBrutalism.borderRadius),
            boxShadow: NeoBrutalism.shadows(offset: 3.0),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: NeoBrutalism.darkBlack,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: NeoBrutalism.darkBlack.withAlpha(128),
                fontWeight: FontWeight.normal,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: NeoBrutalism.darkBlack)
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            ),
          ),
        ),
      ],
    );
  }
}
