// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServicesModel {
  String? service_name;
  String? service_description;
  String? slug;
  String? image;
  int? hourly_rate;
  bool? is_available;
  int? id;
  int? total_providers;
  String? errorMessage;
  // String? ;
  String? rate;
  ServicesModel({
    this.service_name,
    this.service_description,
    this.slug,
    this.image,
    this.hourly_rate,
    this.is_available,
    this.id,
    this.total_providers,
    this.errorMessage,
    this.rate,
  });
  ServicesModel.withError(String error) {
    errorMessage = error;
  }
  ServicesModel copyWith({
    String? service_name,
    String? service_description,
    String? slug,
    String? image,
    int? hourly_rate,
    bool? is_available,
    int? id,
    int? total_providers,
    String? errorMessage,
    String? rate,
  }) {
    return ServicesModel(
      service_name: service_name ?? this.service_name,
      service_description: service_description ?? this.service_description,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      hourly_rate: hourly_rate ?? this.hourly_rate,
      is_available: is_available ?? this.is_available,
      id: id ?? this.id,
      total_providers: total_providers ?? this.total_providers,
      errorMessage: errorMessage ?? this.errorMessage,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'service_name': service_name,
      'service_description': service_description,
      'slug': slug,
      'image': image,
      'hourly_rate': hourly_rate,
      'is_available': is_available,
      'id': id,
      'total_providers': total_providers,
      'errorMessage': errorMessage,
      'rate': rate,
    };
  }

  factory ServicesModel.fromMap(Map<String, dynamic> map) {
    return ServicesModel(
      service_name:
          map['service_name'] != null ? map['service_name'] as String : null,
      service_description: map['service_description'] != null
          ? map['service_description'] as String
          : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      hourly_rate:
          map['hourly_rate'] != null ? map['hourly_rate'] as int : null,
      is_available:
          map['is_available'] != null ? map['is_available'] as bool : null,
      id: map['id'] != null ? map['id'] as int : null,
      total_providers:
          map['total_providers'] != null ? map['total_providers'] as int : null,
      errorMessage:
          map['errorMessage'] != null ? map['errorMessage'] as String : null,
      rate: map['rate'] != null ? map['rate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesModel.fromJson(String source) =>
      ServicesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServicesModel(service_name: $service_name, service_description: $service_description, slug: $slug, image: $image, hourly_rate: $hourly_rate, is_available: $is_available, id: $id, total_providers: $total_providers, errorMessage: $errorMessage, rate: $rate)';
  }

  @override
  bool operator ==(covariant ServicesModel other) {
    if (identical(this, other)) return true;

    return other.service_name == service_name &&
        other.service_description == service_description &&
        other.slug == slug &&
        other.image == image &&
        other.hourly_rate == hourly_rate &&
        other.is_available == is_available &&
        other.id == id &&
        other.total_providers == total_providers &&
        other.errorMessage == errorMessage &&
        other.rate == rate;
  }

  @override
  int get hashCode {
    return service_name.hashCode ^
        service_description.hashCode ^
        slug.hashCode ^
        image.hashCode ^
        hourly_rate.hashCode ^
        is_available.hashCode ^
        id.hashCode ^
        total_providers.hashCode ^
        errorMessage.hashCode ^
        rate.hashCode;
  }
}
