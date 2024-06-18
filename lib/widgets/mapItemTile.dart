import 'package:flutter/material.dart';
import 'package:geopins/models/mapItems.dart';
import 'package:geopins/widgets/commons.dart';

class MapItemTile extends StatelessWidget {
  const MapItemTile({
    super.key,
    required this.mapItem,
  });
  final MapItem mapItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(mapItem.name);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage('assets/tileBg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              mapItem.name,
              color: Colors.white,
              size: 18,
              weight: FontWeight.w600,
              spacing: 1,
            ),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
