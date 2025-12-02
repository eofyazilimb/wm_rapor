import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  TextStyle get ktsTitleVeryLarge =>
      GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w500);
  TextStyle get ktsTitleLarge =>
      GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle get ktsTitleMedium =>
      GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle get ktsTitleSmall =>
      GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle get ktsButtonText =>
      GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle get ktsButtonTextSmall =>
      GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold);
  TextStyle get ktsFieldText =>
      GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500);

  TextStyle get ktsBodyLarge =>
      GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle get ktsBodyMedium =>
      GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get ktsBodySmall =>
      GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold);
  TextStyle get ktsBodyVerySmall =>
      GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.w500);
}
