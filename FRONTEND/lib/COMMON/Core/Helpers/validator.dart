class UserIDValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "User ID can't be empty";
    }
    if(value.length < 2) {
      return "User ID must be at least 2 characters long";
    }
    if(value.length > 50) {
      return "User ID must be less than 50 characters long";
    }
    return null;
  }
  //TODO: Add search through database to see if user ID exists or not
}

class NameValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "Name can't be empty";
    }
    if(value.length < 2) {
      return "Full Name must be at least 2 characters long and as written in your password";
    }
    if(value.length > 70) {
      return "Full Name must be less than 50 characters long and as written in your password";
    }
    return null;
  }
}

class UsernameValidator {
  static String? validate(String value) {
    if (value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
    // Return null if the entered username is valid
    return null;
  }
}


class PasswordValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "Password can't be empty";
    } else if(value.length < 8){
      return 'Password Should be at least 8 characters ';
    }
    return null;
  }
}

class PhoneNumberValidator {
  static String? validate(String value) {
    String pattern = r'(^(?:[+249])?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Phone number can't be empty";
    }
    else if (!regExp.hasMatch(value)) {
      return 'Enter a valid Sudanese Phone Number';
    }
    return null;
  }
}

class RegistrationMedicalHistoryYesNoQuestionsValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }
}

class TaskTitleValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "Name can't be empty";
    }
    if(value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if(value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class TaskDescriptionValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "Name can't be empty";
    }
    if(value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if(value.length > 1000) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class TaskDueDateValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class TaskDueTimeValidator {
  static String? validate(String value) {
    if(value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}