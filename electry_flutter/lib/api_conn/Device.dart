class Device{
  int devId;
  String devName;
  String devDesc;
  String imagePath;
  int devState;
  int devFav;

  Device({this.devId, this.devName, this.devDesc, this.imagePath, this.devState, this.devFav});

  factory Device.fromJson(Map<String, dynamic> json){
    return Device(
      devId: json["DEV_ID"] as int,
      devName: json["DEV_NAME"] as String,
      devDesc: json["DEV_DESC"] as String,
      imagePath: json["IMAGE_PATH"] as String,
      devState: json["DEV_STATE"] as int,
      devFav: json["DEV_FAV"] as int,
    );
  }
}