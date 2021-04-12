import 'package:mobx/mobx.dart';
import 'package:xlomobx/models/ad.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/repositories/ad_repository.dart';

import 'filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    autorun((_) async {
      try {
        setLoading(true);
        final newAds = await AdRepository().getHomeAdList(
          filter: filter,
          search: search,
          category: category,
          page: page,
        );
        addNewAds(newAds);
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e);
      }
    });
  }

  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filter = FilterStore();
  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore value) {
    filter = value;
    resetPage();
  }

  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  String error;

  @action
  void setError(String value) => error = value;
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  @action
  void addNewAds(List<Ad> newAds) {
    if (newAds.length < 20) lastPage = true;
    adList.addAll(newAds);
  }

  @computed
  bool get showProgress => loading && adList.isEmpty;
}
