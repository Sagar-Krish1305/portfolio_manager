import 'package:flutter/material.dart';

/// 🎨 Backgrounds
const Color kBackgroundColor = Color(0xFF0F0F14);   // Main background (fixed alpha)
const Color kCardBackground = Color(0xFF101216);     // Card background (dark but slightly raised)

/// 🌈 Primary Accent
const Color kPrimaryCyan = Color(0xFF1ECBE1);        // Accent cyan (buttons, highlights)

/// 📝 Text Colors
const Color kTextColor = Colors.white;               // Main text
const Color kTextMuted = Color(0xFFA9ADC1);          // Subdued grayish-blue text

/// 📈 Semantic Colors
const Color kProfitColor = Color(0xFF6FE1D3);         // Bright teal for profit
const Color kLossColor = Color(0xFFD32F2F);           // Vivid red for loss

/// 🌅 Gradient (Used in line charts or ₹ value)
const Gradient kAmountGradient = LinearGradient(
  colors: [
    kProfitColor, // Top (light teal)
    kPrimaryCyan,      // Bottom (accent cyan)
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
