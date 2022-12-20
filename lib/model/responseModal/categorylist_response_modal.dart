import 'package:swift_care/export.dart';
import 'package:swift_care/model/data_model/categorylist_item_data_modal.dart';

import '../data_model/category_data_model.dart';
import 'family_response_model.dart';

class CategoryListResponseModal {
  Categories? categories;
  List<TopRatedSubCatgories>? topRatedSubCatgories;
  String? copyrighths;

  CategoryListResponseModal(
      {this.categories, this.topRatedSubCatgories, this.copyrighths});

  CategoryListResponseModal.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
    if (json['top_rated_sub_catgories'] != null) {
      topRatedSubCatgories = <TopRatedSubCatgories>[];
      json['top_rated_sub_catgories'].forEach((v) {
        topRatedSubCatgories!.add(new TopRatedSubCatgories.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    if (this.topRatedSubCatgories != null) {
      data['top_rated_sub_catgories'] =
          this.topRatedSubCatgories!.map((v) => v.toJson()).toList();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

class Categories {
  List<CategoryListItem>? list;
  Links? lLinks;
  Meta? mMeta;

  Categories({this.list, this.lLinks, this.mMeta});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CategoryListItem>[];
      json['list'].forEach((v) {
        list!.add(CategoryListItem.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
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
    return data;
  }
}

class Links {
  Self? self;
  Self? first;
  Self? last;

  Links({this.self, this.first, this.last});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    first = json['first'] != null ? new Self.fromJson(json['first']) : null;
    last = json['last'] != null ? new Self.fromJson(json['last']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.toJson();
    }
    if (this.first != null) {
      data['first'] = this.first!.toJson();
    }
    if (this.last != null) {
      data['last'] = this.last!.toJson();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Meta {
  int? totalCount;
  int? pageCount;
  int? currentPage;
  int? perPage;

  Meta({this.totalCount, this.pageCount, this.currentPage, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageCount'] = this.pageCount;
    data['currentPage'] = this.currentPage;
    data['perPage'] = this.perPage;
    return data;
  }
}

class TopRatedSubCatgories {
  int? id;
  String? title;
  int? categoryId;
  String? description;
  int? typeId;
  int? stateId;
  String? createdOn;
  int? createdById;
  String? image;

  TopRatedSubCatgories(
      {this.id,
      this.title,
      this.categoryId,
      this.description,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.createdById,
      this.image});

  TopRatedSubCatgories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    description = json['description'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['image'] = this.image;
    return data;
  }
}


