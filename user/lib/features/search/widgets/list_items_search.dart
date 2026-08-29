import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend_user/core/constant/app_route.dart';
import 'package:frontend_user/data/model/item/item_model.dart';
import 'package:flutter/material.dart';

class ListItemsSearch extends StatelessWidget {
  final List<ItemModel> items;
  const ListItemsSearch({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true, // لتجنب تعارض الارتفاع داخل ListView الأب
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        final ItemModel item = items[i];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoute.itemsDetails,
              arguments: item,
            );
          },
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 900),
                    height: 90,
                    padding: const EdgeInsets.all(8),
                    child: CachedNetworkImage(
                      imageUrl: item.image!,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                // تفاصيل المنتج (الاسم، القسم، السعر)
                Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text(
                      item.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${item.category?.name}"),
                        const SizedBox(height: 5),
                        // عرض السعر بعد الخصم إذا وجد
                        Text(
                          "${item.discountedPrice ?? item.price} ر.س",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
