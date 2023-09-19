import 'package:get/get.dart';

class LocalLanguage extends Translations{
  @override

  Map<String, Map<String, String>> get keys => {

    'en_US':{
      'next':'Next' ,
      'farmerlogin' : 'Farmer Login' ,
      'expertlogin' : 'Expert Login' ,
      'google': 'Login with Google' ,
      'signout':'SignOut',
    } ,

    'hi_IN':{
      'next':'अगला' ,
      'farmerlogin' : 'किसान लॉगिन' ,
      'expertlogin' : 'विशेषज्ञ लॉगिन' ,
      'google': 'गूगल से लॉगिन करें' ,
      'signout':'साइन आउट',
    }

  };

}