import 'package:dio/dio.dart';
import 'package:xlomobx/models/address.dart';
import 'package:xlomobx/models/city.dart';
import 'package:xlomobx/repositories/ibge_repository.dart';

class CepRepository {
  Future<Address> getAddressFromApi(String cep) async {
    final invalidCep = Future.error('CEP Inválido');
    if (cep == null || cep.isEmpty) return invalidCep;

    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');

    if (clearCep.length != 8) return invalidCep;

    final endpoint = 'http://viacep.com.br/ws/$clearCep/json';

    try {
      final response = await Dio().get<Map>(endpoint);

      if (response.data.containsKey('erro') && response.data['erro'])
        return invalidCep;

      final ufList = await IBGERepository().getUFList();

      return Address(
          cep: response.data['cep'],
          district: response.data['bairro'],
          city: City(name: response.data['localidade']),
          uf: ufList.firstWhere((uf) => uf.initials == response.data['uf']));
    } catch (e) {
      return Future.error('Falha ao buscar CEP');
    }
  }
}
