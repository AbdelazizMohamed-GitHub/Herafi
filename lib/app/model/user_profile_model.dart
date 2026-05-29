import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';

final HerafiModel currentUserProfile = HerafiModel(
  id: '0',
  name: 'عبدالعزيز محمد عبدالعزيز',
  jobTitle: ['مطور تطبيقات', 'باك اند'],
  location: 'الشموت - بنها',
  phone: '01012345678',
  imageUrl: HerafiImage.user,
  createdAt: DateTime.now(),
);
