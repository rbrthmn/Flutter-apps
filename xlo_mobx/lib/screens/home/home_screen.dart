import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlomobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlomobx/screens/home/components/ad_tile.dart';
import 'package:xlomobx/stores/home_store.dart';

import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  openSearch(BuildContext context) async {
    final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(
              currentSearch: homeStore.search,
            ));
    if (search != null) homeStore.setSearch(search);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              if (homeStore.search.isEmpty) return Container();
              return GestureDetector(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return Container(
                      width: constraints.biggest.width,
                      child: Text(homeStore.search),
                    );
                  },
                ),
                onTap: () => openSearch(context),
              );
            },
          ),
          actions: [
            Observer(builder: (_) {
              if (homeStore.search.isEmpty)
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    openSearch(context);
                  },
                );
              return IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  homeStore.setSearch('');
                },
              );
            })
          ],
        ),
        body: Column(
          children: [
            TopBar(),
            Expanded(child: Observer(builder: (_) {
              if (homeStore.error != null)
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 100,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ocorreu um erro!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                );
              if (homeStore.showProgress)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              if (homeStore.adList.isEmpty)
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.border_clear,
                        color: Colors.white,
                        size: 100,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Humm... Nenhum anúncio encontrado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                );
              return ListView.builder(
                itemCount: homeStore.itemCount,
                itemBuilder: (_, index) {
                  if (index < homeStore.adList.length)
                    return AdTile(homeStore.adList[index]);

                  homeStore.loadNextPage();
                  return Container(
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                },
              );
            }))
          ],
        ),
      ),
    );
  }
}
