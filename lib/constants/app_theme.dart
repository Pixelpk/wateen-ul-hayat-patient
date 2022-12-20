import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData themeData = new ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  primaryColorDark: lTextColorDark,
  primaryColorLight: lTextColorLight,
  cardColor: lCardColor,
  scaffoldBackgroundColor: lScaffoldColor,
  bottomAppBarColor: primaryColor,
  backgroundColor: lFillColorLight,
  buttonColor: buttonColor,
  highlightColor: lBorderColor,
  fontFamily: GoogleFonts.poppins().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: lCardColor,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 22, color: primaryColor),
    headline2: TextStyle(
        fontSize: 20, color: lTextColorDark, fontWeight: FontWeight.w500),
    headline3: TextStyle(fontSize: 18, color: lTextColorDark),
    headline4: TextStyle(fontSize: 16, color: lTextColorDark),
    headline5: TextStyle(fontSize: 15, color: lTextColorDark),
    subtitle1: TextStyle(fontSize: 14, color: lTextColorDark),
    subtitle2: TextStyle(fontSize: 13, color: lTextColorDark),
    bodyText1: TextStyle(fontSize: 12, color: lTextColorDark),
    bodyText2: TextStyle(fontSize: 10, color: lTextColorDark),
  ),
  iconTheme: IconThemeData(color: primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    border: lOutlineBorder(),
    enabledBorder: lOutlineBorder(),
    focusedBorder: lFocusOutlineBorder(),
    errorBorder: lErrorOutlineBorder(),
    disabledBorder: lOutlineBorder(),
    focusedErrorBorder: lOutlineBorder(),
    labelStyle: TextStyle(color: lTextColorDark, fontSize: 12.0),
  ),
);

ThemeData darkThemeData = new ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  primaryColorDark: dTextColorDark,
  primaryColorLight: dTextColorLight,
  cardColor: dCardColor,
  scaffoldBackgroundColor: dScaffoldColor,
  bottomAppBarColor: primaryColor,
  backgroundColor: dFillColorLight,
  buttonColor: buttonColor,
  highlightColor: dBorderColor,
  fontFamily: GoogleFonts.poppins().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: dCardColor,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 22, color: primaryColor),
    headline2: TextStyle(
        fontSize: 20, color: lTextColorDark, fontWeight: FontWeight.w500),
    headline3: TextStyle(fontSize: 18, color: dTextColorDark),
    headline4: TextStyle(fontSize: 16, color: dTextColorDark),
    headline5: TextStyle(fontSize: 15, color: dTextColorDark),
    subtitle1: TextStyle(fontSize: 14, color: dTextColorDark),
    subtitle2: TextStyle(fontSize: 13, color: dTextColorDark),
    bodyText1: TextStyle(fontSize: 12, color: dTextColorDark),
    bodyText2: TextStyle(fontSize: 10, color: dTextColorDark),
  ),
  iconTheme: IconThemeData(color: primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    border: dOutlineBorder(),
    enabledBorder: dOutlineBorder(),
    focusedBorder: dFocusOutlineBorder(),
    errorBorder: dErrorOutlineBorder(),
    disabledBorder: dOutlineBorder(),
    focusedErrorBorder: dOutlineBorder(),
    labelStyle: TextStyle(color: dTextColorDark, fontSize: 12.0),
  ),
);

OutlineInputBorder lOutlineBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    width: 1,
    color: lBorderColor,
  ),
);

OutlineInputBorder lFocusOutlineBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    width: 1,
    color: lTextColorDark,
  ),
);

OutlineInputBorder lErrorOutlineBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    width: 1,
    color: Colors.red,
  ),
);

OutlineInputBorder dOutlineBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    width: 1,
    color: dBorderColor,
  ),
);

OutlineInputBorder dFocusOutlineBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    width: 1,
    color: dTextColorDark,
  ),
);

OutlineInputBorder dErrorOutlineBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    width: 1,
    color: Colors.red,
  ),
);
