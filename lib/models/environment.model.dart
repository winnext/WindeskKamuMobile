class EnvironmentModel {
  String? PPP_PROJECT;
  String? BASE_URL_V2;
  String? TOKEN_V1;
  String? TOKEN_V2;
  String? ATTACHPATHLIVE;
  String? base_url_v1;

  EnvironmentModel({
    this.PPP_PROJECT,
    this.BASE_URL_V2,
    this.TOKEN_V1,
    this.TOKEN_V2,
    this.ATTACHPATHLIVE,
    this.base_url_v1,
  });
  EnvironmentModel.fromJson(Map<String, dynamic> json) {
    PPP_PROJECT = json['PPP_PROJECT'];
    BASE_URL_V2 = json['BASE_URL_V2'];
    TOKEN_V1 = json['TOKEN_V1'];
    TOKEN_V2 = json['TOKEN_V2'];
    ATTACHPATHLIVE = json['ATTACHPATHLIVE'];
    base_url_v1 = json['base_url_v1'];
  }
}
