import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final void Function() onSearch;
  final void Function()? onFavorite;
  final bool isFavorite;

  const CustomAppBar({
    super.key,
    required this.onSearch,
    required this.title,
    this.onFavorite,
    this.isFavorite = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              // جعل الحقل للقراءة فقط ليعمل كـ زر ينتقل بنا لشاشة البحث
              readOnly: true,
              onTap: onSearch, // عند الضغط على أي مكان في الحقل تفتح الشاشة
              decoration: InputDecoration(
                hintText: title,
                hintStyle: const TextStyle(fontSize: 18),
                prefixIcon: IconButton(
                  onPressed: onSearch,
                  icon: Icon(Icons.search_outlined, color: Colors.grey[600]),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          if (isFavorite) ...[
            const SizedBox(width: 10),
            _buildAppBarButton(
              onPressed: onFavorite,
              icon: Icons.favorite_outline,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAppBarButton({
    required void Function()? onPressed,
    required IconData icon,
  }) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.grey[600]),
      ),
    );
  }
}
