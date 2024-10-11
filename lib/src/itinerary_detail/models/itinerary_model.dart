class ItineraryApp {
  int? id;
  String? startDate;
  String? endDate;
  int? travelDays;
  String? placesToTravel;
  int? adults;
  int? children;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  ItineraryApp(
      {this.startDate,
      this.endDate,
      this.travelDays,
      this.placesToTravel,
      this.adults,
      this.children,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  ItineraryApp.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    travelDays = json['travel_days'];
    placesToTravel = json['places_to_travel'];
    adults = json['adults'];
    children = json['children'];
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['travel_days'] = this.travelDays;
    data['places_to_travel'] = this.placesToTravel;
    data['adults'] = this.adults;
    data['children'] = this.children;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }

  static ItineraryApp fromStrapiResponse(Map<String, dynamic> data) {
    var attributes = data['attributes'];
    ItineraryApp itineraryApp = ItineraryApp.fromJson(attributes);
    itineraryApp.id = data['id'];
    return itineraryApp;
  }
}
