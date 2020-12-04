import 'package:mobx/mobx.dart';
import 'package:xlomobx/models/address.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/stores/cep_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (imagesValid || !showErrors)
      return null;
    else
      return 'Insira imagens';
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 6;
  String get titleError {
    if (titleValid || !showErrors)
      return null;
    else if (title.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 10;
  String get descriptionError {
    if (descriptionValid || !showErrors)
      return null;
    else if (description.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Descrição muito curto';
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError {
    if (categoryValid || !showErrors)
      return null;
    else
      return 'Campo obrigatório';
  }

  CepStore cepStore = CepStore();

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError {
    if (addressValid || !showErrors)
      return null;
    else
      return 'Campo obrigatório';
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price <= 9999999;
  String get priceError {
    if (priceValid || !showErrors)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Preço inválido';
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  void _send() {}
}
