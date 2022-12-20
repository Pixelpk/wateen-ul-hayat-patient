import 'package:flutter/material.dart';

///---------------Common Color--------------------------------

const Color primaryColor = Color(0xff11ABC6);
const Color primaryColorLight = Color(0xffEBF3F5);
const buttonColor = Color(0xff09BEDE);
const Color statusBarColor = Color(0xff3AC8E0);

///--------------------Light theme color defined-----------------------------

const bannerGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xff11abc6), Color(0x0009bede)],
);
BoxDecoration cardDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
        offset: Offset(0, 4),
        blurRadius: 12)
  ],
  color: Color.fromRGBO(255, 255, 255, 1),
);
BoxDecoration appBarDeco = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
        offset: Offset(0, 4),
        blurRadius: 12)
  ],
  color: Color.fromRGBO(255, 255, 255, 1),
);
const Color lScaffoldColor = Color(0xffF5F5F5);
const Color lTextColorDark = Color(0xff444444);
const Color lTextColorLight = Color(0xff747474);
const Color lBorderColor = Color(0xffE5E5E5);
const Color lFillColorLight = Color(0xffFAFAFA);
const Color lCardColor = Color(0xffFFFFFF);
const Color lRoleButtonSelectedColor = Color(0xff055360);
const Color lDropDownColor = Color(0xffF3F3F3);
const Color lLightGreyColor = Color(0xfff9f9f9);

///--------------------Dark theme color defined-----------------------------

const Color dScaffoldColor = Color(0xff444444);
const Color dTextColorDark = Colors.white;
const Color dTextColorLight = Colors.white;
const Color dBorderColor = Colors.black;
const Color dFillColorLight = Colors.grey;
const Color dCardColor = Colors.black;
const Color dRoleButtonSelectedColor = Color(0xff055360);
const Color dDropDownColor = Color(0xffF3F3F3);
const Color dLightGreyColor = Color(0xfff9f9f9);

///-------------------------------------------------

const Color COLOR_cottonCandy = Color.fromRGBO(255, 196, 235, 1.0);
const Color COLOR_palePurplePantone = Color.fromRGBO(255, 228, 250, 1.0);
const Color COLOR_mistyRose = Color.fromRGBO(241, 222, 220, 1.0);
const Color COLOR_dutchWhite = Color.fromRGBO(225, 218, 189, 1.0);
const Color COLOR_darkSeaGreen = Color.fromRGBO(171, 199, 152, 1.0);
const Color COLOR_white = Color.fromRGBO(255, 255, 255, 1.0);
const Color COLOR_russianVoilet = Color.fromRGBO(49, 37, 98, 1.0);
const Color COLOR_lightGray = Color.fromRGBO(204, 204, 204, 1.0);
const Color COLOR_cultured = Color.fromRGBO(247, 247, 247, 1.0);
const Color COLOR_middleblue = Color.fromRGBO(107, 204, 224, 1.0);
const Color COLOR_middleblues = Color.fromRGBO(2, 105, 144, 1.0);
const Color COLOR_BG = Color.fromRGBO(2, 104, 144, 1.0);
const COLOR_voiletM = MaterialColor(
  0xFF312562,
  <int, Color>{
    0: Color(0xFF3C2D76),
    50: Color(0xFF6B57A5),
    100: Color(0xFF080649),
  },
);

const COLOR_whiteM = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    100: Color(0xFFCCCCCC),
  },
);

const COLOR_middleBlueM = MaterialColor(
  0xFF6bcce0,
  <int, Color>{
    0: Color(0xFF6bcce0),
    50: Color(0xFFa0ffff),
    100: Color(0xFF319bae),
  },
);
const COLOR_pinkM = MaterialColor(
  0xFFD84990,
  <int, Color>{
    0: Color(0xFFD84990),
    50: Color(0xFFff7cc0),
    100: Color(0xFFa30263),
  },
);

const appColor = Color(0xff00678e);
const indigoColor = Color(0xff264c72);
const indigoBlackColor = Color(0xff142b32);
const lightBlue = Color(0xff00b4c6);
const fadeBlue = Color(0xfff1fbfc);


const loginDeco = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  ),
  boxShadow: [
    BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.07000000029802322),
        offset: Offset(0, 6),
        blurRadius: 24)
  ],
  color: Color.fromRGBO(255, 255, 255, 1),
);
