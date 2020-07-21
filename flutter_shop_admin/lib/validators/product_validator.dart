class ProductValidator {

  String validatorImages(List images) {
    if(images.isEmpty) return "Adicione imagens do produto";
    return null;
  }

  String validatorTitle(String text) {
    if(text.isEmpty) return "Preencha o título do produto";
    return null;
  }

  String validatorDescription(String text) {
    if(text.isEmpty) return "Preencha a descrição do produto";
    return null;
  }

 String validatorPrice(String text) {
    double price = double.tryParse(text);
    if(price != null) {
      if(!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preço inválido";
    }
    return null;
 }
}