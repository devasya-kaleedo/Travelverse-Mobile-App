class VisaApp {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? generatedFrom;
  int? pax;
  String? country;
  int? quote;
  String? visaReference;
  String? status;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? applicationDate;
  String? expectedDate;
  Document? document;

  VisaApp(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.generatedFrom,
      this.pax,
      this.country,
      this.quote,
      this.visaReference,
      this.status,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.applicationDate,
      this.expectedDate});

  VisaApp.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    generatedFrom = json['generated_from'];
    pax = json['pax'];
    country = json['country'];
    quote = json['quote'];
    visaReference = json['visa_reference'];
    status = json['status'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    applicationDate = json['application_date'];
    expectedDate = json['expected_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['generated_from'] = this.generatedFrom;
    data['pax'] = this.pax;
    data['country'] = this.country;
    data['quote'] = this.quote;
    data['visa_reference'] = this.visaReference;
    data['status'] = this.status;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['application_date'] = this.applicationDate;
    data['expected_date'] = this.expectedDate;
    return data;
  }

  static VisaApp fromStrapiResponse(Map<String, dynamic> data) {
    var attributes = data['attributes'];
    VisaApp visaApp = VisaApp.fromJson(attributes);
    visaApp.id = data['id'];
    Document doc = Document.fromJson(attributes['document']);
    visaApp.document = doc;
    return visaApp;
  }
}

class Document {
  int? id;
  String? name;
  Null? alternativeText;
  Null? caption;
  Null? width;
  Null? height;
  Null? formats;
  String? hash;
  String? ext;
  String? mime;
  double? size;
  String? url;
  Null? previewUrl;
  String? provider;
  Null? providerMetadata;
  String? createdAt;
  String? updatedAt;

  Document(
      {this.name,
      this.alternativeText,
      this.caption,
      this.width,
      this.height,
      this.formats,
      this.hash,
      this.ext,
      this.mime,
      this.size,
      this.url,
      this.previewUrl,
      this.provider,
      this.providerMetadata,
      this.createdAt,
      this.updatedAt});

  Document.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats = json['formats'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
    providerMetadata = json['provider_metadata'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    data['formats'] = this.formats;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    data['provider'] = this.provider;
    data['provider_metadata'] = this.providerMetadata;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static Document fromStrapiResponse(Map<String, dynamic> data) {
    var attributes = data['attributes'];
    Document doc = Document.fromJson(attributes);
    doc.id = attributes['id'];
    doc.url = 'https://dev.strapi.travelverse.in${attributes['url']}';
    return doc;
  }
}
