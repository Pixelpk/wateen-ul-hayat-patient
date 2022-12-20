class CategoryListItem {
  int? id;
  String? title;
  int? categoryId;
  String? description;
  String? imageFile;
  int? typeId;
  int? stateId;
  String? createdOn;
  int? createdById;

  CategoryListItem(
      {this.id,
        this.title,
        this.categoryId,
        this.description,
        this.typeId,
        this.stateId,
        this.imageFile,
        this.createdOn,
        this.createdById});

  CategoryListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    description = json['description'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    imageFile = json['image_file'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['image_file'] = this.imageFile;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}