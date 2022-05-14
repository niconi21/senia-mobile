class ValidationsTools {
  
  static final String _emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String? emailValidation(String? value) {
    String pattern = _emailRegex;
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value ?? '') ? null : 'Correo no válido';
  }

  static String? nameValidation(String? value) {
    if(value!=null && value.length>=3){
      return null;
    }
    return "El nombre debe contener al menos 3 carácteres";
  }
}
