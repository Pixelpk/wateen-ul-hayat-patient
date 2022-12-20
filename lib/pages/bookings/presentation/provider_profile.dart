import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/components/custom_appbar.dart';
import 'package:swift_care/components/custom_text.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/loginController.dart';
import 'package:swift_care/pages/bookings/presentation/submit_rating_screen.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/pages/service_providers/presentation/views/book_now_screen.dart';

import '../../../../export.dart';

class ProviderProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceProviderController>(
      init: BookServiceProviderController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: backAppBar2(
                context: context,
                title: text('Mery Seacole',
                    fontWeight: FontWeight.w600, fontSize: FONT_18),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    vGap(16),
                    userImage(),
                    vGap(DIMENS_10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: DIMENS_20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: DIMENS_5,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )

                    ),
                    vGap(DIMENS_10),
                    InkWell(
                      onTap: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: text('(123 Reviews)',
                            color: Colors.blueGrey, fontSize: FONT_12),
                      ),
                    ),
                    vGap(DIMENS_10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: text(
                          STRING_preparePatientsDummy +
                              ' ' +
                              STRING_preparePatientsDummy,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          color: Colors.blueGrey,
                          fontSize: FONT_12),
                    ),
                    vGap(DIMENS_10),
                    divider(),
                    vGap(DIMENS_10),
                    _personalInfo()
                  ],
                ),
              ),
            ),
          );
        }
    );
  }



  sliverView(BookServiceProviderController controller) {
    // return GetBuilder<LoginController>(builder: (controller) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
              children: [
                vGap(16),
                userImage(),
                vGap(DIMENS_10),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: DIMENS_20,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: DIMENS_5,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )

                ),
                vGap(DIMENS_10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: text('(123 Reviews)',
                      color: Colors.blueGrey, fontSize: FONT_12),
                ),
                vGap(DIMENS_10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: text(
                      STRING_preparePatientsDummy +
                          ' ' +
                          STRING_preparePatientsDummy,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      color: Colors.blueGrey,
                      fontSize: FONT_12),
                ),
                vGap(DIMENS_10),
                divider(),
              ],
            ),
            childCount: 1,
          ), //SliverChildBuildDelegate
        ),
        SliverAppBar(
          snap: false,
          pinned: true,
          floating: false,
          elevation: 0,
          leading: Container(),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.zero,
            title: _tabs(controller),

          ),
          backgroundColor: Colors.transparent,
          expandedHeight: 56,
          collapsedHeight: 56,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {

              if (controller.currentTabIndex == 0) {
                return _personalInfo();
              } else if (controller.currentTabIndex == 1) {
                return _services();
              } else {
                return _availability();
              }

            },
            childCount: 1,
          ), //SliverChildBuildDelegate
        ),
      ],
    );
    //   }
    // );
  }

  _tabs(BookServiceProviderController controller) {
    return Container(
      height: 200,
      width: Get.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (){
              controller.updateCurrentTabIndex(0);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: text(STRING_personalInfo.tr,
                  color: controller.currentTabIndex==0?indigoColor:Colors.grey,
                  fontSize: FONT_18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            color: Colors.grey.shade400,
            height: DIMENS_20,
            width: 2,
          ),
          InkWell(
            onTap: (){
              controller.updateCurrentTabIndex(1);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: text(STRING_services.tr,
                  color: controller.currentTabIndex==1?indigoColor:Colors.grey,
                  fontSize: FONT_18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            color: Colors.grey.shade400,
            height: DIMENS_20,
            width: 2,
          ),
          InkWell(
            onTap: (){
              controller.updateCurrentTabIndex(2);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: text(STRING_availability.tr,
                  color: controller.currentTabIndex==2?indigoColor:Colors.grey,
                  fontSize: FONT_18,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  userImage() {
    return Center(
      child: Container(
        height: DIMENS_90,
        width: DIMENS_90,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:AssetImage(IMAGE_dummy2)
            ),
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)]),
      ),
    );
  }

  divider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 5,
    );
  }

  _tabView(){
    return PageView(

      children: [
        _personalInfo(),
        _services(),
        _availability()
      ],
    );
  }


  _personalInfo(){
    return ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _fieldLayout(title: 'Experience',subtitle: '5 Years'),
        _certificateFieldLayout(),
        _uploadedImagesFieldLayout(),
        vGap(100)
      ],
    );
  }

  _fieldLayout({title,subtitle}){
    return ListTile(
      title: text(title??'',fontWeight: FontWeight.w500),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: text(subtitle??'',color: indigoColor,fontWeight: FontWeight.w500),
      ),
    );
  }

  _certificateFieldLayout(){
    return ListTile(
      title: text(STRING_certifications.tr,fontWeight: FontWeight.w500),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(bottom: 20),
        height: DIMENS_80,
        width: DIMENS_80,
        alignment: Alignment.topLeft,
        child: imageAsset(ICON_certificate,fit: BoxFit.contain),
      ),
    );
  }

  _uploadedImagesFieldLayout(){
    return ListTile(
      title: text('Uploaded Images',fontWeight: FontWeight.w500),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(bottom: 20),
        height: DIMENS_80,
        width: DIMENS_80,
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            imageAsset(IMAGE_dummy2,fit: BoxFit.contain),
            hGap(10),
            imageAsset(IMAGE_dummy2,fit: BoxFit.contain),
            hGap(10),
            imageAsset(IMAGE_dummy2,fit: BoxFit.contain),

          ],
        ),
      ),
    );
  }

  _services(){
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index)=>_serviceLayout(),
        separatorBuilder: (context,index)=>Divider(color: Colors.grey.shade300,thickness: 2,),
        itemCount: 8
    );
  }

  _availability(){
    return Container();
  }

  _serviceLayout(){
    return Container(
      height: DIMENS_90,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                text('Home Consultant-Nursing Assessment',fontSize: FONT_16,maxLines: 2),
                vGap(DIMENS_15),
                Row(
                  children: [
                    Expanded(child: text('${STRING_gender.tr}: Female',fontSize: FONT_14,color: Colors.grey)),
                    Expanded(child: text('${STRING_price.tr}: ${STRING_CURRENCY.tr} 110',fontSize: FONT_14,color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: (){
                  // Get.to(BookNowScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                  decoration: BoxDecoration(
                      color: indigoColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: text('ADD',color: Colors.white),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}

Widget doubleText(topText, bottomText) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    text(topText, maxLines: 1, fontSize: 16),
    vGap(4),
    text(bottomText,
        color: Colors.black, isBold: true, fontSize: 16, maxLines: 1),
  ],
);
