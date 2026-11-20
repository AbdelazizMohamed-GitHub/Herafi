import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomHomeLoadingWidget extends StatelessWidget {
  const CustomHomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,

        itemCount: 10,

        separatorBuilder: (context, index) {
          return const Divider(thickness: 0.8, height: 20);
        },
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(radius: 40, backgroundColor: Colors.grey),
              title: SizedBox(
                height: 20,
                width: 250,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
              subtitle: SizedBox(
                height: 14,
                width: 180,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
              trailing: SizedBox(
                height: 20,
                width: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
