import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:swift_care/model/data_model/card_details.dart';
import 'package:swift_care/model/data_model/service_provider_detail_model.dart';
import 'package:swift_care/model/data_model/service_provider_model.dart';
import 'package:swift_care/model/responseModal/categorylist_response_modal.dart';
import 'package:swift_care/model/responseModal/family_response_model.dart';
import 'package:swift_care/model/responseModal/faq_response_model.dart';
import 'package:swift_care/model/responseModal/home_model.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/nationalities_response_model.dart';
import 'package:swift_care/model/responseModal/otp_verification_response_model.dart';
import 'package:swift_care/model/responseModal/service_db_response_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/model/responseModal/slot_data_model.dart';
import 'package:swift_care/model/responseModal/subcategory_response_model.dart';
import 'package:swift_care/service/remote_service/network/endpoint.dart';
import 'package:swift_care/service/remote_service/network/network_exceptions.dart';

import '../../../export.dart' hide log;
import '../../../model/data_model/booking_detail_model.dart';
import '../../../model/data_model/booking_model.dart';
import '../../../model/data_model/category_data_model.dart';
import '../../../model/data_model/static_page_model.dart';
import '../../../model/responseModal/availabilitySlot.dart';
import '../../../model/responseModal/notification_data_model.dart';
import '../../../pages/cart/cart_data_model.dart';
import 'dio_client.dart';

class APIRepository {
  static late DioClient? dioClient;

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
  }

  /*===================================================================== Sign Up API Call  ==========================================================*/
  static Future signUpApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(end_pt_signupApi,
          data: FormData.fromMap(dataBody!), skipAuth: true);
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== contact Us API Call  ==========================================================*/
  static Future contactUsApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(contactUsApiEndpoint,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future verifyOtpApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(end_pt_verifyOTPApi,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return OtpVerificationResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future resendOTPApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(end_pt_resendOTPApi,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future loginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(end_pt_loginApi,
          data: FormData.fromMap(dataBody!), skipAuth: true);
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future profileUpdateApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(end_pt_updateUserDetailApiUrl,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future nationalitiesListApiCall() async {
    try {
      final response =
          await dioClient!.get(end_pt_nationalitiesListApiUrl, skipAuth: false);
      return NationalitiesResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future getUserProfileApiCall(int id) async {
    try {
      final response = await dioClient!.get(end_pt_getUserDetailApiUrl,
          skipAuth: false, queryParameters: {'id': id});
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future<StaticPageModel> staticPagesApiCall(int type) async {
    try {
      final response = await dioClient!.get(end_pt_staticPage,
          skipAuth: true, queryParameters: {'type_id': type});
      return StaticPageModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future addFamilyMemberApiCall(
      {Map<String, dynamic>? dataBody, id}) async {
    debugPrint(dataBody.toString());

    try {
      final response = await dioClient!.post(end_pt_addFamilyMember,
          queryParameters: {"id": id},
          data: FormData.fromMap(dataBody!),
          skipAuth: false);
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future getFamilyMembersListApiCall() async {
    try {
      final response = await dioClient!.get(
        end_pt_FamilyMemberList,
        skipAuth: false,
      );
      return FamilyMembersListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future logoutApiCall() async {
    try {
      final response = await dioClient!.get(
        end_pt_logout,
        skipAuth: false,
      );
      return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future changePasswordApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(end_pt_changePassword,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return MyAccountModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future forgetApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      debugPrint('dataBody :::::: $dataBody');
      final response = await dioClient!.post(end_pt_forgotPassword,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      debugPrint('dataBody :::::: $response');
      return response['otp'] == null ? response['message'] : response['otp'];
      // return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future updatePasswordApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      debugPrint('dataBody :::::: $dataBody');
      final response = await dioClient!.post(end_pt_updatePassword,
          data: FormData.fromMap(dataBody!), skipAuth: true);
      debugPrint('dataBody :::::: $response');
      return  response['message'];
      // return SignUpResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future myAccountApiCall() async {
    try {
      final response = await dioClient!.post(myAccount);
      return MyAccountModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future homeListApiCall() async {
    try {
      final response = await dioClient!.post(myBook);
      return (response as List).map((p) => HomeModel.fromJson(p)).toList();
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<CategoryListResponseModal> serviceTypeListAPiCall(
      {required String search, int? page}) async {
    try {
      final response = await dioClient!.get(categoryListApiEndpoint,
          skipAuth: false, queryParameters: {titleKey: search, 'page': page});
      log("RESPONSEE ::: $response");
      return CategoryListResponseModal.fromJson(response);
    } catch (e) {
      log(e.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<SubCategoryListResponseModal> SubserviceTypeListAPiCall(
      {required int categoryId, int? page}) async {
    try {
      final response = await dioClient!.get(subCategoryListApiEndpoint,
          skipAuth: false,
          queryParameters: {categoryIdKey: categoryId, 'page': page});

      return SubCategoryListResponseModal.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  static Future<ServiceProviderModel> providerListAPiCall(
      {Map<String, dynamic>? dataBody,
      required int? categoryId,
      required int? subCategoryId,
      int? page,
      lat,
      lng}) async {
    try {
      var token = await storage.read(LOCALKEY_token);
      final response = await dioClient!.post(providerListApiEndpoint,
          skipAuth: false,
          data: FormData.fromMap(dataBody!),
          queryParameters: {
            categoryIdKey: categoryId,
            subCategoryIdKey: subCategoryId,
           /* 'lat': lat,
            'long': lng,
            'page': page*/
          },
          options: Options(headers: {
            categoryIdKey: categoryId,
            subCategoryIdKey: subCategoryId,
            "Authorization": "Bearer $token"
          }));

      return ServiceProviderModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<CategoryDataModel> serviceListAPiCall(int id, page) async {
    try {
      final response = await dioClient!.get(
        serviceListApiEndpoint,
        queryParameters: {'provider_id': id, 'page': page},
        skipAuth: false,
      );

      return CategoryDataModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future langApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
        setLangugageApiEndpoint,
        data: FormData.fromMap(dataBody!),
        skipAuth: false,
      );
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<SlotModel> availabilityListAPiCall(int id) async {
    try {
      final response = await dioClient!.get(
        availabilityListApiEndpoint,
        queryParameters: {"provider_id": id},
        skipAuth: false,
      );

      return SlotModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<NotificationDataModel> notificationListAPiCall() async {
    try {
      final response = await dioClient!.get(
        end_pt_NotificationList,
        skipAuth: false,
      );

      return NotificationDataModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<FaqResponseModel> faqListAPiCall() async {
    try {
      final response = await dioClient!.get(
        faqListApiEndpoint,
        skipAuth: false,
      );

      return FaqResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<BookingNewModel> bookingListAPiCall(
      {int? type, int? page}) async {
    try {
      final response = await dioClient!.get(
        bookingListApiEndpoint,
        queryParameters: {"booking_type": type, "page": page},
        skipAuth: false,
      );

      return BookingNewModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future notificationToggleAPiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
        notificationToggleApiEndpoint,
        data: FormData.fromMap(dataBody!),
        skipAuth: false,
      );

      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future getServiceProviderProfileApiCall(int id) async {
    try {
      final response = await dioClient!.get(end_pt_getUserDetailApiUrl,
          skipAuth: false, queryParameters: {'id': id});
      return ServiceProviderDetailModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future getSlotApiCall(
      {Map<String, dynamic>? dataBody,
      required int id,
      required int subId}) async {
    try {
      final response = await dioClient!.post(getSlotApiEndpoint,
          queryParameters: {"provider_id": id, "service_id": subId},
          data: FormData.fromMap(dataBody!),
          skipAuth: false);
      return SlotModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<AvailabilitySlotModel> getAvailabilitySlotApiCall(
      {Map<String, dynamic>? dataBody,
      required int id,
      required int subId}) async {
    try {
      final response = await dioClient!.post(getSlotAvailabilityApiEndpoint,
          queryParameters: {"provider_id": id, "service_id": subId},
          data: FormData.fromMap(dataBody!),
          skipAuth: false);
      return AvailabilitySlotModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future bookingApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(bookingApiEndpoint,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future addAddressApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(addAddressApiEndpoint,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<BookingDetailModel> getBookingDetailApiCall(int id) async {
    try {
      final response = await dioClient!.get(bookingDetailApiEndpoint,
          skipAuth: false, queryParameters: {'id': id});
      return BookingDetailModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static getDeleteMemberApiCall(int id) async {
    try {
      final response = await dioClient!.get(deleteFamilyMemberApiEndpoint,
          skipAuth: false, queryParameters: {'id': id});
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static getDeleteCardApiCall(String id) async {
    try {
      final response = await dioClient!.get(deleteCardApiEndpoint,
          skipAuth: false, queryParameters: {'card_id': id});
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static getDefaultCardApiCall(String id) async {
    try {
      final response = await dioClient!.get(defaultCardApiEndpoint,
          skipAuth: false, queryParameters: {'card_id': id});
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future getBookingApiCall({Map<String, dynamic>? dataBody, id}) async {
    try {
      final response = await dioClient!.post(
        getPaymentEndpoint,
        skipAuth: false,
        queryParameters: {'id': id},
        data: FormData.fromMap(dataBody!),
      );
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future getLocationApiCall(int i) async {
    try {
      final response = await dioClient!.get(getLocationEndpoint,
          skipAuth: false, queryParameters: {'id': i});
      return response;
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static giveRatingApiCall(
      {Map<String, dynamic>? dataBody, required int id}) async {
    try {
      final response = await dioClient!.post(giveRatingApiEndpoint,
          skipAuth: false,
          queryParameters: {'booking_id': id},
          data: FormData.fromMap(dataBody!));
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static filterApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(filterApiEndpoint, skipAuth: false);
      return response['message'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<ServiceDB> postCartApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(postCartApiEndpoint,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return response['response'];
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<FamilyMembersListResponseModel> familyMemberListAPiCall(
      int type) async {
    try {
      final response = await dioClient!.get(
        familyMemberListApiEndpoint,
        skipAuth: false,
      );

      return FamilyMembersListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<CardDetailsModel> cardListAPiCall() async {
    try {
      final response = await dioClient!.get(
        cardListApiEndpoint,
        skipAuth: false,
      );

      return CardDetailsModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future<ServiceDbResponseModel> getCartAPiCall() async {
    try {
      final response = await dioClient!.get(
        getCartApiEndpoint,
        skipAuth: false,
      );

      return ServiceDbResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future addCardApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(addCardApiEndpoint,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return response;
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
}
