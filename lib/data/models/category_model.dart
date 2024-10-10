class CategoryModel{
  final int id;
  final String fireID;
  final categoryName;
  final List<dynamic>? subCategories;
  final status;
  final image;
  final imageRefPath;

CategoryModel({required this.imageRefPath,required this.fireID, this.image,this.status,required this.id,this.categoryName,this.subCategories});


Map<String, dynamic> toMap(){
  return{
    "fireID":fireID,
    "id":id,
    "categoryName":categoryName,
    "subCategories":subCategories,
    "status":status,
    "image":image,
    "imageRefPath":imageRefPath,
  };
}

}

List<String> categoryTableTitle=[
  "Image",
  "ID",
  "Name",
  "Description",
  "Status",
  "Actions",
];
