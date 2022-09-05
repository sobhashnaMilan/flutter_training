import 'package:get/get.dart';
class LocaleString extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    //ENGLISH LANGUAGE
    'en_US':{
      'welcome':'Welcome',
      'message':'Multi language support',
      'changeLanguage':'Change Language'
    },
    //HINDI LANGUAGE
    'hi_IN':{
      'welcome': 'स्वागत',
      'message':'बहु भाषा समर्थन',
      'changeLanguage':'भाषा बदलो'
    },
    //GUJARATI LANGUAGE
    'gu_IN':{
      'welcome': 'સ્વાગત છે',
      'message':'મલ્ટી-લેંગ્વેજ સપોર્ટ',
      'changeLanguage':'ભાષા બદલો'
    },
    'ar_AE': {
      "welcome": "أهلا وسهلا",
      "message": "دعم متعدد اللغات",
      "changeLanguage": "تغيير اللغة"
    },
  };
}