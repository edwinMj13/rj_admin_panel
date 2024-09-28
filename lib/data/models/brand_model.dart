class BrandModel{
  final int id;
  final String nodeId;
  final name;
  final status;
  final image;
  final imageRefPath;
  BrandModel({this.status,this.name,required this.id,this.image,required this.nodeId,required this.imageRefPath});

  Map<String, dynamic> toMap(){
    return {
      "id":id,
      "name":name,
      "status":status,
      "image":image,
      "nodeId":nodeId,
      "imageRefPath":imageRefPath,
    };
  }


}

List<String> brandTableTitle=[
  "ID",
  "Name",
  "Status",
  "Actions",
];

// List<BrandModel> brandTableData=[
//   BrandModel(id: '8138QW',name: 'Taparia',status: 'Available'),
//   BrandModel(id: '9538QW',name: 'BestArc',status: 'Available'),
//   BrandModel(id: '3438QW',name: 'Supreme',status: 'Available'),
//   BrandModel(id: '6738QW',name: 'GoldMedal',status: 'Available'),
//   BrandModel(id: '7838QW',name: 'Hi-Fi',status: 'Available'),
//   BrandModel(id: '1238QW',name: 'Pidilite',status: 'Available'),
//   BrandModel(id: '3038QW',name: 'Vguard',status: 'Available'),
// ];