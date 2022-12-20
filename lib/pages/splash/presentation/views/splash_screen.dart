import '../../../../export.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   return Scaffold(body: GetBuilder<SplashController>(
     init: SplashController(),
          builder: (controller) {
            return Stack(
              children: [
                Container(
                  width: Get.width,
                  child: Image.asset(ICON_splashBg,fit: BoxFit.cover,),
                ),
                Center(child: Image.asset(ICON_whiteAppLogo,height: DIMENS_150,width: DIMENS_150,)),
              ],
            );
          },
        ));

  }
}
