import 'package:frontend_user/features/search/bloc/search_bloc.dart'; // مسار الـ Bloc الجديد
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_user/features/search/widgets/list_items_search.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc;

  CustomSearchDelegate({required this.searchBloc});

  // 1. الأزرار التي تظهر في يمين الـ AppBar (مثال: زر مسح النص)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // المتغير المدمج في فلاتر لنص البحث
          searchBloc.add(const SearchEvent.clearSearch());
        },
      ),
    ];
  }

  // 2. الزر الافتراضي في يسار الـ AppBar (زر الرجوع)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // إغلاق شاشة البحث والعودة
      },
    );
  }

  // 3. ماذا يحدث عندما يضغط المستخدم على زر البحث في الكيبورد (Submit)
  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchEvent.queryChanged(query));
    return _buildSearchResultsAndStates();
  }

  // 4. ماذا يعرض أثناء كتابة المستخدم (تحديث تلقائي أو عند الضغط)
  @override
  Widget buildSuggestions(BuildContext context) {
    // إذا كنت تريد البحث التلقائي أثناء الكتابة، فك التجميد عن السطر التالي:
    // searchBloc.add(SearchEvent.queryChanged(query));

    return _buildSearchResultsAndStates();
  }

  // دالة مشتركة لعرض الحالات والنتائج بناءً على حالة الـ Bloc
  Widget _buildSearchResultsAndStates() {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc:
          searchBloc, // نمرر الـ bloc هنا صراحة لأن الشاشة تفتح خارج سياق الشاشة الأصلية
      builder: (context, state) {
        return state.status.when(
          initial: () => const Center(child: Text("ابحث عن منتجاتك المفضلة")),
          loading: () => const Center(child: CircularProgressIndicator()),
          notFound: () =>
              const Center(child: Text("لم نجد أي نتائج تطابق بحثك")),
          failure: (error) => Center(child: Text(error)),
          loaded: () => ListItemsSearch(items: state.searchResults),
        );
      },
    );
  }
}
