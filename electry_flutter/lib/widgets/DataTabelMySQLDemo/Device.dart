class Device{
  int dev_id;
  String dev_name;
  String dev_desc;
  String image_path;
  int dev_state;
  int dev_fav;

  Device({this.dev_id, this.dev_name, this.dev_desc, this.image_path, this.dev_state, this.dev_fav});

  factory Device.fromJson(Map<String, dynamic> json){
    return Device(
      dev_id: json["DEV_ID"] as int,
      dev_name: json["DEV_NAME"] as String,
      dev_desc: json["DEV_DESC"] as String,
      image_path: json["IMAGE_PATH"] as String,
      dev_state: json["DEV_STATE"] as int,
      dev_fav: json["DEV_FAV"] as int,
    );
  }
}