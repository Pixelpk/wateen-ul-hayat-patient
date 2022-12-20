import '../data_model/category_data_model.dart';
import '../data_model/categorylist_item_data_modal.dart';

class SubCategoryListResponseModal {
  List<CategoryListItem>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  SubCategoryListResponseModal(
      {this.list, this.lLinks, this.mMeta, this.copyrighths});

  SubCategoryListResponseModal.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CategoryListItem>[];
      json['list'].forEach((v) {
        list!.add(new CategoryListItem.fromJson(v));
      });
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
