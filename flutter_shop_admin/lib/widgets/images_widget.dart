import 'package:flutter/material.dart';

class ImagesWidget extends FormField<List> {
  ImagesWidget({FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
    List initialValue,
    bool autoValidate = false});
}