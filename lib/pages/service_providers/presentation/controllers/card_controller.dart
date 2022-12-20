import 'package:swift_care/export.dart';

import '../../../../model/data_model/card_details.dart';
import '../../../../service/remote_service/entity/request_model/auth_reuest_model.dart';

class CardController extends GetxController{

  List<CardDetails>? cardList;
  late TextEditingController cardNumberController;
  late TextEditingController expiryNoController;
  late TextEditingController cvvController;
  late TextEditingController cardNameController;



  @override
  void onInit() {

    cardNumberController = TextEditingController();
    expiryNoController = TextEditingController();
    cvvController = TextEditingController();
    cardNameController = TextEditingController();

    cardListHitApi();
    super.onInit();
  }

  cardListHitApi() {
    Loader.show(Get.context);
    APIRepository.cardListAPiCall().then((value) {
      if(value!=null){
        Loader.hide();
        cardList = value.cardDetails ?? [];
        if(cardList!.length !=0){
          storage.write(LOCALKEY_cardList, true);
        }else{
          storage.write(LOCALKEY_cardList, false);
        }
        update();
      }else{
        Loader.hide();
        storage.write(LOCALKEY_cardList, false);
      }
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error);
    });

  }


  hitDeleteCardAPI(id) async {
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.getDeleteCardApiCall(id).then((value) async {
      snackBar(value);
      cardListHitApi();
      update();
    }).onError((error, stackTrace) {
      snackBar(error);
    });
  }

  hitDefaultCardAPI(id) async {
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.getDefaultCardApiCall(id).then((value) async {
      snackBar(value);
      cardListHitApi();
      update();
    }).onError((error, stackTrace) {
      snackBar(error);
    });
  }

  hitAddCardApi() {
    Loader.show(Get.context);
    FocusManager.instance.primaryFocus!.unfocus();
    var contactUsReq = AuthRequestModel.addCardReq(
        fullName: cardNameController.text.trim(),
        cardNumber: cardNumberController.text.trim(),
        cvv: cvvController.text.trim(),
        expiryDate: expiryNoController.text.trim());
    APIRepository.addCardApiCall(dataBody: contactUsReq).then((value) async {
      clearFields();
      cardListHitApi();
      Get.back();
      Loader.hide();
    }).onError((error, stackTrace) {
      Loader.hide();
      if (error.toString() == STRING_unexpectedException) {
        Loader.hide();
      } else {
        snackBar(error);
        Loader.hide();
      }
    });
  }


  clearFields(){
    cardNameController.clear();
    cardNumberController.clear();
    cvvController.clear();
    expiryNoController.clear();
  }
}