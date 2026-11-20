import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/home/presention/widget/custom_herafi_item_widget.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key, required this.herafiResultList});
  final List<HerafiModel> herafiResultList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتائج البحث'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return CustomHerafiItemWidget(herafi: herafiResultList[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
        itemCount: herafiResultList.length,
      ),
    );
  }
}
