class AllSponsers {
  String? sponserName;
  double? sponserNumber;
  // String? sponserLocation;
  String? sponserImage;
  String? sponserDetail;
  String? sponserStatus;

  AllSponsers({
    this.sponserName,
    this.sponserNumber,
    this.sponserImage,
    this.sponserDetail,
    // this.sponserLocation,
    this.sponserStatus
  });

  AllSponsers.fromJson(Map<String, dynamic> map) {
    sponserName = map['name'];
    sponserNumber = map['id'];
    sponserDetail = map['description'];
    sponserImage = map['logoUrl'];
    sponserStatus = map['status'];
  }
}
