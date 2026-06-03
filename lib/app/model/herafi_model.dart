class HerafiModel {
  final String id;
  final String name;
  final List<String> jobTitle;
  final String location;
  final String phone;
  final String imageUrl;
  final DateTime createdAt;

  const HerafiModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.location,
    required this.phone,
    required this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'jobTitle': jobTitle,
      'location': location,
      'phone': phone,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HerafiModel.fromMap(Map<String, dynamic> map) {
    return HerafiModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      jobTitle: List<String>.from(map['jobTitle'] ?? []),
      location: map['location'] ?? '',
      phone: map['phone'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
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
    phone: "01000000001",
    imageUrl: "assets/images/user1.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "2",
    name: "أحمد حسن",
    jobTitle: ["كهربائي منازل"],
    location: "شبرا - القاهرة",
    phone: "01000000002",
    imageUrl: "assets/images/user2.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "3",
    name: "محمد علي",
    jobTitle: ["سباك صحي"],
    location: "المطرية - القاهرة",
    phone: "01000000003",
    imageUrl: "assets/images/user3.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "4",
    name: "حسام إبراهيم",
    jobTitle: ["نجار أثاث"],
    location: "مدينة نصر",
    phone: "01000000004",
    imageUrl: "assets/images/user4.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "5",
    name: "محمود السيد",
    jobTitle: ["ميكانيكي سيارات"],
    location: "الجيزة",
    phone: "01000000005",
    imageUrl: "assets/images/user5.png",
    createdAt: DateTime.now(),
  ),
  HerafiModel(
    id: "6",
    name: "عمر خالد",
    jobTitle: ["فني تكييف"],
    location: "حلوان",
    phone: "01000000006",
    imageUrl: "assets/images/user6.png",
    createdAt: DateTime.now(),
  ),
];
