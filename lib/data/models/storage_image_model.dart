class StorageImageModel{
  final String storageRefPath;
  final String downloadUrl;

  StorageImageModel({required this.storageRefPath, required this.downloadUrl});

  Map<String, dynamic> toMap(){
    return {
      "storageRefPath":storageRefPath,
      "downloadUrl":downloadUrl,
    };
  }
  
  StorageImageModel fromMap(Map<String,dynamic> map){
    return StorageImageModel(storageRefPath: map["storageRefPath"], downloadUrl: map["downloadUrl"]);
  }

}