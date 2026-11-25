class HerafiModel {
  final String id;
  final String name;
  final List<String> jobTitle;
  final String? location;
  final String phoneNumber;
  final String? imageUrl;
  final double rating;
  final int reviewsCount;
  final DateTime createdAt;

  const HerafiModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.location,
    required this.phoneNumber,
    required this.imageUrl,
    this.rating = 0,
    this.reviewsCount = 0,
    required this.createdAt,
  });

  HerafiModel copyWith({
    String? id,
    String? name,
    List<String>? jobTitle,
    String? location,
    String? phoneNumber,
    String? imageUrl,
    double? rating,
    int? reviewsCount,
    DateTime? createdAt,
  }) {
    return HerafiModel(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {...toProfileMap(), 'rating': rating, 'reviewsCount': reviewsCount};
  }

  Map<String, dynamic> toProfileMap() {
    return {
      'id': id,
      'name': name,
      'jobTitle': jobTitle,
      'location': location,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HerafiModel.fromMap(Map<String, dynamic> map) {
    return HerafiModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      jobTitle: List<String>.from(map['jobTitle'] ?? []),
      location: map['location'] ?? 'لا يوجد عنوان',
      phoneNumber: map['phoneNumber'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0,
      reviewsCount: (map['reviewsCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

final List<HerafiModel> dummyHerafiList = [
  HerafiModel(
    id: "1",
    name: "عبدالعزيز محمد",
    jobTitle: ["مطور تطبيقات"],
    location: "الشموت - بنها",
    phoneNumber: "01000000001",
    imageUrl: "assets/images/user1.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "2",
    name: "أحمد حسن",
    jobTitle: ["كهربائي منازل"],
    location: "شبرا - القاهرة",
    phoneNumber: "01000000002",
    imageUrl: "assets/images/user2.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "3",
    name: "محمد علي",
    jobTitle: ["سباك صحي"],
    location: "المطرية - القاهرة",
    phoneNumber: "01000000003",
    imageUrl: "assets/images/user3.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "4",
    name: "حسام إبراهيم",
    jobTitle: ["نجار أثاث"],
    location: "مدينة نصر",
    phoneNumber: "01000000004",
    imageUrl: "assets/images/user4.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "5",
    name: "محمود السيد",
    jobTitle: ["ميكانيكي سيارات"],
    location: "الجيزة",
    phoneNumber: "01000000005",
    imageUrl: "assets/images/user5.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "6",
    name: "عمر خالد",
    jobTitle: ["فني تكييف"],
    location: "حلوان",
    phoneNumber: "01000000006",
    imageUrl: "assets/images/user6.png",
    createdAt: DateTime.now(),
  ),
];
