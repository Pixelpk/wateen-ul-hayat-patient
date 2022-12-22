import '../data_model/category_data_model.dart';
import '../data_model/categorylist_item_data_modal.dart';

class SubCategoryListResponseModal {
  List<CategoryListItem>? list;
  List<Services>? allServices;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  SubCategoryListResponseModal({this.list, this.lLinks, this.mMeta, this.copyrighths});

  SubCategoryListResponseModal.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CategoryListItem>[];
      try {
        list = List.from(json['list']).map((e) => CategoryListItem.fromJson(e)).toList();
      } catch (error) {
        print(error);
      }
    } else {
      print("data sahi bhejoooo");
    }

    if (json['AllServices'] != null) {
      allServices = <Services>[];
      try {
        allServices = List.from(json['AllServices']).map((e) => Services.fromJson(e)).toList();
      } catch (error) {
        print(error);
      }
    } else {
      print("data sahi bhejoooo");
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    if (this.mMeta != null) {
      data['_meta'] = this.mMeta!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}
