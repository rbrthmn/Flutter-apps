import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlomobx/stores/cep_store.dart';
import 'package:xlomobx/stores/create_store.dart';

class CepField extends StatelessWidget {
  CepField(this.createStore) : cepStore = createStore.cepStore;

  final CreateStore createStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(builder: (_) {
          return TextFormField(
            onChanged: cepStore.setCep,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            decoration: InputDecoration(
                errorText: createStore.addressError,
                labelText: 'CEP *',
                labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10)),
          );
        }),
        Observer(builder: (_) {
          final a = cepStore.address;
          if (a == null && cepStore.error == null && !cepStore.loading)
            return Container();
          else if (a == null && cepStore.error == null)
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.purple),
              backgroundColor: Colors.transparent,
            );
          else if (cepStore.error != null)
            return Container(
              alignment: Alignment.center,
              color: Colors.red.withAlpha(100),
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                cepStore.error,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            );
          else {
            return Container(
              alignment: Alignment.center,
              color: Colors.purple.withAlpha(150),
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Localização: ${a.district}, ${a.city.name} - ${a.uf.initials}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        })
      ],
    );
  }
}
