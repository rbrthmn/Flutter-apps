import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlomobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlomobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
        fontWeight: FontWeight.w800, fontSize: 18, color: Colors.grey);
    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagesField(createStore),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título *',
                  labelStyle: labelStyle,
                  contentPadding: contentPadding,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição *',
                  labelStyle: labelStyle,
                  contentPadding: contentPadding,
                ),
                maxLines: null,
              ),
              CategoryField(createStore),
              CepField(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço *',
                  labelStyle: labelStyle,
                  contentPadding: contentPadding,
                  prefixText: 'R\$ ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter(centavos: true),
                ],
              ),
              HidePhoneField(createStore),
              SizedBox(
                height: 50,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Enviar',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Colors.orange,
                  disabledColor: Colors.orange.withAlpha(120),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}