// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  String? image;
  String? title;
  String? id;
  Function? ontap;

  CustomImage({
    super.key,
    this.image,
    this.title,
    this.id,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return Container(
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => ontap!(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: ResizeImage(
                      NetworkImage('$image'),
                      width: MediaQuery.of(context).size.width.toInt(),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Text(
                '$title $id',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
