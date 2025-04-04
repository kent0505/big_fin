abstract final class AppFonts {
  static const medium = 'medium';
  static const bold = 'bold';
  static const black = 'black';
  static const dosis = 'dosis';
  static const sf = 'sf';
}

abstract final class Assets {
  static const add = 'assets/add.svg';
  static const back = 'assets/back.svg';
  static const date1 = 'assets/date1.svg';
  static const date2 = 'assets/date2.svg';
  static const right = 'assets/right.svg';
  static const top = 'assets/top.svg';
  static const bottom = 'assets/bottom.svg';
  static const close = 'assets/close.svg';
  static const check = 'assets/check.svg';
  static const income = 'assets/income.svg';
  static const expense = 'assets/expense.svg';
  static const calendar = 'assets/calendar.svg';
  static const delete = 'assets/delete.svg';
  static const search = 'assets/search.svg';
  static const attachment = 'assets/attachment.svg';
  static const photo = 'assets/photo.svg';
  static const pen = 'assets/pen.svg';
  static const send = 'assets/send.svg';
  static const premium = 'assets/premium.png';

  static const onb1 = 'assets/onboard/onb1.jpg';
  static const onb2 = 'assets/onboard/onb2.jpg';
  static const onb3 = 'assets/onboard/onb3.jpg';
  static const onb4 = 'assets/onboard/onb4.jpg';
  static const stars = 'assets/onboard/stars.svg';
  static const leaves1 = 'assets/onboard/leaves1.svg';
  static const leaves2 = 'assets/onboard/leaves2.svg';

  static const tab1 = 'assets/tab/tab1.svg';
  static const tab2 = 'assets/tab/tab2.svg';
  static const tab3 = 'assets/tab/tab3.svg';
  static const tab4 = 'assets/tab/tab4.svg';
  static const tab5 = 'assets/tab/tab5.svg';

  static const set1 = 'assets/settings/set1.svg';
  static const set2 = 'assets/settings/set2.svg';
  static const set3 = 'assets/settings/set3.svg';
  static const set4 = 'assets/settings/set4.svg';
  static const set5 = 'assets/settings/set5.svg';
  static const set6 = 'assets/settings/set6.svg';
  static const set7 = 'assets/settings/set7.svg';
  static const set8 = 'assets/settings/set8.svg';
  static const set9 = 'assets/settings/set9.svg';
  static const set10 = 'assets/settings/set10.svg';
  static const set11 = 'assets/settings/set11.svg';
  static const set12 = 'assets/settings/set12.svg';
  static const set13 = 'assets/settings/set13.svg';
  static const set14 = 'assets/settings/set14.svg';
  static const diamond = 'assets/settings/diamond.svg';

  static const news1 = 'assets/news/news1.jpg';
  static const news2 = 'assets/news/news2.png';
  static const news3 = 'assets/news/news3.png';
  static const news4 = 'assets/news/news4.png';
  static const news5 = 'assets/news/news5.png';
  static const news6 = 'assets/news/news6.png';
  static const news7 = 'assets/news/news7.png';
  static const news8 = 'assets/news/news8.png';
  static const news9 = 'assets/news/news9.png';
  static const news10 = 'assets/news/news10.png';

  static const icon1 = 'assets/icons/icon1.png';
  static const icon2 = 'assets/icons/icon2.png';
  static const icon3 = 'assets/icons/icon3.png';
  static const icon4 = 'assets/icons/icon4.png';
  static const icon5 = 'assets/icons/icon5.png';
  static const icon6 = 'assets/icons/icon6.png';
}

abstract final class Locales {
  static const defaultLocale = 'en';
  static const ru = 'ru';
  static const es = 'es';
  static const de = 'de';
}

abstract final class Currencies {
  static const usd = '\$';
  static const eur = '€';
  static const gbp = '£';
  static const rub = '₽';
  static const uah = '₴';
  static const values = [usd, eur, gbp, rub, uah];
}

abstract final class ApiKeys {
  static const geminiApiKey = 'AIzaSyCzpFUnPoqx11NfWTyPYLugaxSHTG7xF04';
}

abstract final class Keys {
  static const onboard = 'onboard';
  static const themeID = 'themeID';
  static const locale = 'locale';
  static const vipPeriod = 'vipPeriod';
  static const vipSeconds = 'vipSeconds';
  static const assistantDayLimit = 'assistantDayLimit';
  static const assistantLastUsed = 'assistantLastUsed';
  static const currency = 'currency';
}

abstract final class Tables {
  static const db = 'data.db';
  static const expenses = 'expenses';
  static const categories = 'categories';
  static const budgets = 'budgets';
  static const calcs = 'calcs';
  static const chats = 'chats';
  static const messages = 'messages';
}

abstract final class SQL {
  static const expenses = '''
    CREATE TABLE IF NOT EXISTS ${Tables.expenses} (
      id INTEGER NOT NULL,
      date TEXT NOT NULL,
      time TEXT NOT NULL,
      title TEXT NOT NULL,
      amount TEXT NOT NULL,
      note TEXT NOT NULL,
      attachment1 TEXT NOT NULL,
      attachment2 TEXT NOT NULL,
      attachment3 TEXT NOT NULL,
      catID INTEGER NOT NULL,
      isIncome INTEGER NOT NULL
    )
    ''';
  static const categories = '''
    CREATE TABLE IF NOT EXISTS ${Tables.categories} (
      id INTEGER NOT NULL,
      title TEXT NOT NULL,
      assetID INTEGER NOT NULL,
      colorID INTEGER NOT NULL
    )
    ''';
  static const budgets = '''
    CREATE TABLE IF NOT EXISTS ${Tables.budgets} (
      id INTEGER NOT NULL,
      monthly INTEGER NOT NULL,
      date TEXT NOT NULL,
      amount TEXT NOT NULL,
      cats TEXT NOT NULL
    )
    ''';
  static const calcs = '''
    CREATE TABLE IF NOT EXISTS ${Tables.calcs} (
      id INTEGER NOT NULL,
      energy TEXT NOT NULL,
      cost TEXT NOT NULL,
      currency TEXT NOT NULL
    )
    ''';
  static const chats = '''
    CREATE TABLE IF NOT EXISTS ${Tables.chats} (
      id INTEGER NOT NULL,
      title TEXT NOT NULL
    )
    ''';
  static const messages = '''
    CREATE TABLE IF NOT EXISTS ${Tables.messages} (
      id INTEGER NOT NULL,
      chatID INTEGER NOT NULL,
      message TEXT NOT NULL,
      fromGPT INTEGER NOT NULL
    )
    ''';
}
