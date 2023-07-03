import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({super.key});

  final List<Map<String, dynamic>> gridList = [
    {
      "title": "Books",
      "image": "books-straight.png",
      "color": const Color(0xFF46466E),
    },
    {
      "title": "Copy",
      "image": "copy-straight.png",
      "color": const Color(0xFF69b4f5),
    },
    {
      "title": "Hijab",
      "image": "hijab-straight.png",
      "color": const Color(0xFF1B2430),
    },
    {
      "title": "Badge",
      "image": "badge-straight.png",
      "color": const Color(0xFFFF7844),
    },
    {
      "title": "Belt",
      "image": "belt-straight.png",
      "color": const Color(0xFF511845),
    },
    {
      "title": "Sweater",
      "image": "sweater-straight.png",
      "color": const Color(0xFFE23E57),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: gridList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return gridCard(
          element: gridList[index],
        );
      },
    );
  }
}

GestureDetector gridCard({required Map<String, dynamic> element}) {
  return GestureDetector(
    onTap: () {},
    child: Card(
      color: Colors.white,
      shape: Border(
        bottom: BorderSide(
          color: element['color'],
          width: 4,
        ),
      ),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(
            size: 40,
            AssetImage('assets/images/${element["image"]}'),
            color: element["color"],
          ),
          const SizedBox(height: 20),
          Text(
            element['title'],
            style: AppTextStyles.text,
          ),
        ],
      ),
    ),
  );
}
