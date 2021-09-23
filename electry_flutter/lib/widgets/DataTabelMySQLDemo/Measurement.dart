class Measurement{
  int id;
  int consumerId;
  String timestamp;
  int power;
  int state;

  Measurement({this.id, this.consumerId, this.timestamp, this.power, this.state});

  factory Measurement.fromJson(Map<String, dynamic> json){
    return Measurement(
      id: json["id"] as int,
      consumerId: json["consumer_id"] as int,
      timestamp: json["timestamp"] as String,
      power: json["power"] as int,
      state: json["state"] as int,
    );
  }
}