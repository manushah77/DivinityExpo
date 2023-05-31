class AllBooths {
  String? boothName;
  double? boothNumber;
  String? boothLocation;
  String? boothImage;
  String? boothDetail;

  AllBooths({
    this.boothName,
    this.boothNumber,
    this.boothImage,
    this.boothDetail,
    this.boothLocation,
  });

  AllBooths.fromJson(Map<String,dynamic> map) {
    boothName = map['boothName'];
    boothNumber = map['boothNumber'];
    boothDetail = map['boothDetail'];
    boothImage = map['boothImage'];
    boothLocation = map['boothLocation'];
  }

}
