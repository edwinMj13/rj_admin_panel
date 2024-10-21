class BannerModel {
  final List<dynamic> bannerImages;
  final String nodeId;

  BannerModel({required this.bannerImages,required this.nodeId});

  Map<String, dynamic> toMap() {
    return {
      "bannerImages": bannerImages.map((item)=>item.toMap()),
      "nodeId": nodeId,
    };
  }
}
