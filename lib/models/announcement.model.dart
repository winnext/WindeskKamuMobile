class AnnouncementViewModel {
  String? NAME;
  String? ANNOUNCEMENT;

 AnnouncementViewModel(
      {
      this.NAME,
      this.ANNOUNCEMENT,
     });
 AnnouncementViewModel.fromJson(Map<String, dynamic> json) {
    NAME = json['NAME'];
    ANNOUNCEMENT = json['ANNOUNCEMENT'];
}
}
