import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/profile_widget.dart';
import 'package:swift_care/components/user_image.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/profile_controller.dart';
import 'package:swift_care/service/remote_service/network/endpoint.dart';
import '../../../../components/family_member_widget.dart';
import '../../../../export.dart';
import '../../../agora/video_calling/spinner.dart';
import '../controllers/complete_profile_screen_controller.dart';
import 'add_family_member.dart';
import 'completer_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var ctrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: DefaultAppBar(
              title: STRING_MyProfile.tr,
              showBackButton: false,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: hMargin),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    vGap(16),
                    Stack(
                      children: <Widget>[
                        Container(
                            width: Get.width,
                            margin: EdgeInsets.only(top: 51),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                vGap(60),
                                ProfileWidget(
                                  label: STRING_fullName.tr,
                                  value:
                                      controller.loginModel?.detail?.fullName,
                                ),
                                ProfileWidget(
                                  label: STRING_mobileNo.tr,
                                  value: '${controller.loginModel?.detail?.countryCode ?? ''} ${controller.loginModel?.detail?.contactNo}',
                                ),
                                ProfileWidget(
                                  label: STRING_EmailID.tr,
                                  value:
                                      '${controller.loginModel?.detail?.email ?? ''}'
                                          .toLowerCase(),
                                ),
                                ProfileWidget(
                                  label: STRING_gender.tr,
                                  value: controller.loginModel?.detail?.gender
                                              .toString() ==
                                          '0'
                                      ? STRING_Male.tr
                                      : STRING_Female.tr,
                                ),
                                ProfileWidget(
                                  label: STRING_nationality.tr,
                                  value: controller.loginModel?.detail
                                      ?.userDetail?.nationality,
                                ),
                                ProfileWidget(
                                  label: STRING_addresss.tr,
                                  showDivider: false,
                                  value:
                                      '${controller.loginModel?.detail?.userAddress?.houseNo ?? ''}, ${controller.loginModel?.detail?.userAddress?.street ?? ''} \n${controller.loginModel?.detail?.userAddress?.otherInfo}',
                                ),
                              ],
                            )),
                        GestureDetector(
                          onTap: (){
                            // showTimerDialog(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCallingScreen()));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PakistaniFlag()));
                          },
                          child: PositionedDirectional(
                            start: 0,
                            top: 0,
                            end: 0,
                            child: UserImage(
                              imageUrl: '$imageUrl${controller.loginModel?.detail?.profileFile}',
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          top: 0,
                          end: 0,
                          child: InkWell(
                            onTap: () {
                              var ctrl = Get.put(CompleteProfileController());
                              ctrl.setUserProfile();
                              Get.to(CompleteProfile(
                                title: STRING_EditProfile.tr,
                              ));
                            },
                            child: Container(
                              width: 80,
                              height: 25,
                              margin: EdgeInsets.only(top: 51),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(10),
                                  bottomStart: Radius.circular(10),
                                ),
                                color: buttonColor,
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 17,
                                    ),
                                    hGap(4),
                                    Text(
                                      STRING_Edit.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    vGap(30),
                    InkWell(
                      onTap: () {
                        Get.to(AddFamilyMember());
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: buttonColor,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: <Widget>[
                            Text(
                              STRING_addFamilyMembers.tr,
                              style: TextStyle(
                                color: lCardColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.add_circle,
                              color: lCardColor,
                              size: 18,
                            ),
                            hGap(2),
                            Text(
                              STRING_Add.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    vGap(20),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller
                              .familyMembersListResponseModel?.list?.length ??
                          0,
                      itemBuilder: (BuildContext context, int index) {
                        var item = controller
                            .familyMembersListResponseModel?.list![index];
                        return FamilyMemberWidget(
                          item: item,
                          onDelete: () {
                            controller.hitDeleteFamilyMembersAPI(controller
                                    .familyMembersListResponseModel
                                    ?.list?[index]
                                    .id ??
                                0);
                          },
                          onEdit: () {
                            Get.to(AddFamilyMember(
                              item: item,
                            ));
                          },
                        );
                      },
                    ),
                    vGap(32),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
