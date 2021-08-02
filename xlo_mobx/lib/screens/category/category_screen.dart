import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlomobx/components/error_box.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({this.selected, this.showAll = true});

  final Category selected;
  final bool showAll;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
          elevation: 8,
          child: Observer(
            builder: (_) {
              if (categoryStore.error != null) {
                return ErrorBox(
                  message: categoryStore.error,
                );
              } else if (categoryStore.categoryList.isEmpty) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ));
              } else {
                final categories = showAll
                    ? categoryStore.allCategoryList
                    : categoryStore.categoryList;

                return ListView.separated(
                  separatorBuilder: (_, __) {
                    return Divider(
                      height: 0.1,
                      color: Colors.grey,
                    );
                  },
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    final category = categories[index];

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        height: 50,
                        color: category.id == selected?.id
                            ? Colors.purple.withAlpha(50)
                            : null,
                        alignment: Alignment.center,
                        child: Text(
                          category.description,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: category.id == selected?.id
                                  ? FontWeight.bold
                                  : null),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
