class TranslatedData {
  Translations? translations;
  Details? details;

  TranslatedData({this.translations, this.details});

  TranslatedData.fromJson(Map<String, dynamic> json) {
    translations = json['translations'] != null
        ? Translations.fromJson(json['translations'])
        : null;
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.translations != null) {
      data['translations'] = this.translations!.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Translations {
  String? text;
  String? translation;
  String? source;
  String? target;

  Translations({this.text, this.translation, this.source, this.target});

  Translations.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    translation = json['translation'];
    source = json['source'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['text'] = this.text;
    data['translation'] = this.translation;
    data['source'] = this.source;
    data['target'] = this.target;
    return data;
  }
}

class Details {
  Details();

  Details.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}
