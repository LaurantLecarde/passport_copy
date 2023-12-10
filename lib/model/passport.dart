class Passport {
  int? id;
  String? fullName;
  String? address;
  String? city;
  String? image;
  String? passportGot;
  String? passportExpire;

  Passport(
      this.id,
      this.fullName,
      this.address,
      this.city,
      this.image,
      this.passportExpire,
      this.passportGot
      );

  Passport.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      fullName = json['full_name'],
      address = json['address'],
      city = json['city'],
      image = json['image'],
      passportGot = json['passport_got'],
        passportExpire = json['passport_expire'];

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'full_name':fullName,
      'address':address,
      'city':city,
      'image':image,
      'passport_got':passportGot,
      'passport_expire':passportExpire,
    };
  }
}