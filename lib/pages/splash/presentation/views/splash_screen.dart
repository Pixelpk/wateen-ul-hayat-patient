import '../../../../export.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xff328797),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.38,
              ),
              Image.asset(
                ICON_splashLogo,
                height: DIMENS_150,
                width: DIMENS_200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: LinearProgressIndicator(
                    color: COLOR_white,
                    backgroundColor: COLOR_middleblue,
                    minHeight: DIMENS_1,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  ICON_splashLogoWhite,
                  height: DIMENS_50,
                  width: DIMENS_56,
                ),
              ),
            ],
          ),
        );
        /*Stack(
              children: [
                Container(
                  width: Get.width,
                  child: Image.asset(ICON_splashBg,fit: BoxFit.cover,),
                ),
                Center(child: Image.asset(ICON_whiteAppLogo,height: DIMENS_150,width: DIMENS_150,)),
              ],
            );*/
      },
    ));
  }
}
