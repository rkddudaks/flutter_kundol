import '../../constants/app_constants.dart';

/// last_tab : ""
/// home_style : "1"
/// category_style : "1"
/// banner_style : "1"
/// card_style : "1"
/// cancel_order_button : "0"
/// cancel_order_hours : "1"
/// package_name : "Package Name"
/// site_url : "http://domain-name.com/"
/// new_product_duration : "20"
/// filter_max_price : "1000"
/// update_order : 8
/// one_page_checkout : "0"
/// checkout_process : "no"
/// custom_css_for_checkout : ".site-header, nav, #secondary, footer {display: none!important;}"
/// contact_us_email : "info@domain-name.com"
/// from_email : "from@domain-name.com"
/// phone_no : "+92 123 456-789"
/// address : "228 Park avs"
/// city : "New York"
/// state : "NY"
/// Zip : "10003"
/// Country : "USA"
/// Latitude : "40.730610"
/// Longitude : "-73.935242"
/// sidebar_menu_icon : "0"
/// wish_list_page : "0"
/// edit_profile_page : "0"
/// shipping_address_page : "0"
/// my_orders_page : "0"
/// contact_us_page : "0"
/// about_us_page : "0"
/// bill_ship_info : "0"
/// downloads : "0"
/// news_page : "0"
/// intro_page : "0"
/// share_app : "0"
/// rate_app : "0"
/// setting_page : "0"
/// notification_title : "Theme Coder"
/// notification_text : "A bundle of products wating for you!"
/// notification_duration : "0"
/// facebook_login : "0"
/// about_page_id : "1959"
/// refund_page_id : "1961"
/// privacy_page_id : "1963"
/// terms_page_id : "1965"
/// wpml_enabled : "0"
/// mvf_enabled : "0"
/// wp_point_reward : "0"
/// wp_multi_currency : "0"
/// delivery_tracking : "0"
/// tracking_url : "http://urltracking.com/"
/// geo_fencing : "0"
/// one_signal_notification : "0"
/// one_signal_app_id : ""
/// one_signal_app_key : ""
/// privacy_page : ""
/// refund_page : ""
/// terms_page : ""
/// about_page : ""
/// currency : {"name":"USD","position":"left"}
/// language : {"code":"en","id":"1","native_name":"English","major":"1","active":"1","default_locale":"en_US","encode_url":"0","tag":"en","translated_name":"English","url":"http://tcshop.androidecommerce.com","country_flag_url":"https://tcshop.androidecommerce.com/wp-content/plugins/sitepress-multilingual-cms/res/flags/en.png","language_code":"en"}

class WooSettingsResponse {
  WooSettingsResponse({
    String? lastTab,
    String? homeStyle,
    String? categoryStyle,
    String? bannerStyle,
    String? cardStyle,
    String? cancelOrderButton,
    String? cancelOrderHours,
    String? packageName,
    String? siteUrl,
    String? newProductDuration,
    String? filterMaxPrice,
    int? updateOrder,
    String? onePageCheckout,
    String? checkoutProcess,
    String? customCssForCheckout,
    String? contactUsEmail,
    String? fromEmail,
    String? phoneNo,
    String? address,
    String? city,
    String? state,
    String? zip,
    String? country,
    String? latitude,
    String? longitude,
    String? sidebarMenuIcon,
    String? wishListPage,
    String? editProfilePage,
    String? shippingAddressPage,
    String? myOrdersPage,
    String? contactUsPage,
    String? aboutUsPage,
    String? billShipInfo,
    String? downloads,
    String? newsPage,
    String? introPage,
    String? shareApp,
    String? rateApp,
    String? settingPage,
    String? notificationTitle,
    String? notificationText,
    String? notificationDuration,
    String? facebookLogin,
    String? aboutPageId,
    String? refundPageId,
    String? privacyPageId,
    String? termsPageId,
    String? wpmlEnabled,
    String? mvfEnabled,
    String? wpPointReward,
    String? wpMultiCurrency,
    String? deliveryTracking,
    String? trackingUrl,
    String? geoFencing,
    // String? oneSignalNotification,
    // String? oneSignalAppId,
    // String? oneSignalAppKey,
    String? privacyPage,
    String? refundPage,
    String? termsPage,
    String? aboutPage,
    Currency? currency,
    Language? language,
  }) {
    _lastTab = lastTab;
    _homeStyle = homeStyle;
    _categoryStyle = categoryStyle;
    _bannerStyle = bannerStyle;
    _cardStyle = cardStyle;
    _cancelOrderButton = cancelOrderButton;
    _cancelOrderHours = cancelOrderHours;
    _packageName = packageName;
    _siteUrl = siteUrl;
    _newProductDuration = newProductDuration;
    _filterMaxPrice = filterMaxPrice;
    _updateOrder = updateOrder;
    _onePageCheckout = onePageCheckout;
    _checkoutProcess = checkoutProcess;
    _customCssForCheckout = customCssForCheckout;
    _contactUsEmail = contactUsEmail;
    _fromEmail = fromEmail;
    _phoneNo = phoneNo;
    _address = address;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
    _latitude = latitude;
    _longitude = longitude;
    _sidebarMenuIcon = sidebarMenuIcon;
    _wishListPage = wishListPage;
    _editProfilePage = editProfilePage;
    _shippingAddressPage = shippingAddressPage;
    _myOrdersPage = myOrdersPage;
    _contactUsPage = contactUsPage;
    _aboutUsPage = aboutUsPage;
    _billShipInfo = billShipInfo;
    _downloads = downloads;
    _newsPage = newsPage;
    _introPage = introPage;
    _shareApp = shareApp;
    _rateApp = rateApp;
    _settingPage = settingPage;
    _notificationTitle = notificationTitle;
    _notificationText = notificationText;
    _notificationDuration = notificationDuration;
    _facebookLogin = facebookLogin;
    _aboutPageId = aboutPageId;
    _refundPageId = refundPageId;
    _privacyPageId = privacyPageId;
    _termsPageId = termsPageId;
    _wpmlEnabled = wpmlEnabled;
    _mvfEnabled = mvfEnabled;
    _wpPointReward = wpPointReward;
    _wpMultiCurrency = wpMultiCurrency;
    _deliveryTracking = deliveryTracking;
    _trackingUrl = trackingUrl;
    _geoFencing = geoFencing;
    // _oneSignalNotification = oneSignalNotification;
    // _oneSignalAppId = oneSignalAppId;
    // _oneSignalAppKey = oneSignalAppKey;
    _privacyPage = privacyPage;
    _refundPage = refundPage;
    _termsPage = termsPage;
    _aboutPage = aboutPage;
    _currency = currency;
    _language = language;
  }

  WooSettingsResponse.fromJson(dynamic json) {
    _lastTab = json['last_tab'];
    _homeStyle = json['home_style'];
    _categoryStyle = json['category_style'];
    _bannerStyle = json['banner_style'];
    _cardStyle = json['card_style'];
    _cancelOrderButton = json['cancel_order_button'];
    _cancelOrderHours = json['cancel_order_hours'];
    _packageName = json['package_name'];
    _siteUrl = json['site_url'];
    _newProductDuration = json['new_product_duration'];
    _filterMaxPrice = json['filter_max_price'];
    _updateOrder = json['update_order'];
    _onePageCheckout = json['one_page_checkout'];
    _checkoutProcess = json['checkout_process'];
    _customCssForCheckout = json['custom_css_for_checkout'];
    _contactUsEmail = json['contact_us_email'];
    _fromEmail = json['from_email'];
    _phoneNo = json['phone_no'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['Zip'];
    _country = json['Country'];
    _latitude = json['Latitude'];
    _longitude = json['Longitude'];
    _sidebarMenuIcon = json['sidebar_menu_icon'];
    _wishListPage = json['wish_list_page'];
    _editProfilePage = json['edit_profile_page'];
    _shippingAddressPage = json['shipping_address_page'];
    _myOrdersPage = json['my_orders_page'];
    _contactUsPage = json['contact_us_page'];
    _aboutUsPage = json['about_us_page'];
    _billShipInfo = json['bill_ship_info'];
    _downloads = json['downloads'];
    _newsPage = json['news_page'];
    _introPage = json['intro_page'];
    _shareApp = json['share_app'];
    _rateApp = json['rate_app'];
    _settingPage = json['setting_page'];
    _notificationTitle = json['notification_title'];
    _notificationText = json['notification_text'];
    _notificationDuration = json['notification_duration'];
    _facebookLogin = json['facebook_login'];
    _aboutPageId = json['about_page_id'];
    _refundPageId = json['refund_page_id'];
    _privacyPageId = json['privacy_page_id'];
    _termsPageId = json['terms_page_id'];
    _wpmlEnabled = json['wpml_enabled'];
    _mvfEnabled = json['mvf_enabled'];
    _wpPointReward = json['wp_point_reward'];
    _wpMultiCurrency = json['wp_multi_currency'];
    _deliveryTracking = json['delivery_tracking'];
    _trackingUrl = json['tracking_url'];
    _geoFencing = json['geo_fencing'];
    // _oneSignalNotification = json['one_signal_notification'];
    // _oneSignalAppId = json['one_signal_app_id'];
    // _oneSignalAppKey = json['one_signal_app_key'];
    _privacyPage = json['privacy_page'];
    _refundPage = json['refund_page'];
    _termsPage = json['terms_page'];
    _aboutPage = json['about_page'];
    _currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    _language =
        json['language'] != null ? Language.fromJson(json['language']) : null;
    this._status = AppConstants.STATUS_SUCCESS;
  }

  WooSettingsResponse.withError(String error) {
    this._status = AppConstants.STATUS_ERROR;
    this._error = error;
  }

  String? _status;
  String? _error;
  String? _lastTab;
  String? _homeStyle;
  String? _categoryStyle;
  String? _bannerStyle;
  String? _cardStyle;
  String? _cancelOrderButton;
  String? _cancelOrderHours;
  String? _packageName;
  String? _siteUrl;
  String? _newProductDuration;
  String? _filterMaxPrice;
  int? _updateOrder;
  String? _onePageCheckout;
  String? _checkoutProcess;
  String? _customCssForCheckout;
  String? _contactUsEmail;
  String? _fromEmail;
  String? _phoneNo;
  String? _address;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;
  String? _latitude;
  String? _longitude;
  String? _sidebarMenuIcon;
  String? _wishListPage;
  String? _editProfilePage;
  String? _shippingAddressPage;
  String? _myOrdersPage;
  String? _contactUsPage;
  String? _aboutUsPage;
  String? _billShipInfo;
  String? _downloads;
  String? _newsPage;
  String? _introPage;
  String? _shareApp;
  String? _rateApp;
  String? _settingPage;
  String? _notificationTitle;
  String? _notificationText;
  String? _notificationDuration;
  String? _facebookLogin;
  String? _aboutPageId;
  String? _refundPageId;
  String? _privacyPageId;
  String? _termsPageId;
  String? _wpmlEnabled;
  String? _mvfEnabled;
  String? _wpPointReward;
  String? _wpMultiCurrency;
  String? _deliveryTracking;
  String? _trackingUrl;
  String? _geoFencing;
  // String? _oneSignalNotification;
  // String? _oneSignalAppId;
  // String? _oneSignalAppKey;
  String? _privacyPage;
  String? _refundPage;
  String? _termsPage;
  String? _aboutPage;
  Currency? _currency;
  Language? _language;

  set status(String? value) {
    _status = value;
  }

  String? get status => _status;

  String? get error => _error;

  String? get lastTab => _lastTab;

  String? get homeStyle => _homeStyle;

  String? get categoryStyle => _categoryStyle;

  String? get bannerStyle => _bannerStyle;

  String? get cardStyle => _cardStyle;

  String? get cancelOrderButton => _cancelOrderButton;

  String? get cancelOrderHours => _cancelOrderHours;

  String? get packageName => _packageName;

  String? get siteUrl => _siteUrl;

  String? get newProductDuration => _newProductDuration;

  String? get filterMaxPrice => _filterMaxPrice;

  int? get updateOrder => _updateOrder;

  String? get onePageCheckout => _onePageCheckout;

  String? get checkoutProcess => _checkoutProcess;

  String? get customCssForCheckout => _customCssForCheckout;

  String? get contactUsEmail => _contactUsEmail;

  String? get fromEmail => _fromEmail;

  String? get phoneNo => _phoneNo;

  String? get address => _address;

  String? get city => _city;

  String? get state => _state;

  String? get zip => _zip;

  String? get country => _country;

  String? get latitude => _latitude;

  String? get longitude => _longitude;

  String? get sidebarMenuIcon => _sidebarMenuIcon;

  String? get wishListPage => _wishListPage;

  String? get editProfilePage => _editProfilePage;

  String? get shippingAddressPage => _shippingAddressPage;

  String? get myOrdersPage => _myOrdersPage;

  String? get contactUsPage => _contactUsPage;

  String? get aboutUsPage => _aboutUsPage;

  String? get billShipInfo => _billShipInfo;

  String? get downloads => _downloads;

  String? get newsPage => _newsPage;

  String? get introPage => _introPage;

  String? get shareApp => _shareApp;

  String? get rateApp => _rateApp;

  String? get settingPage => _settingPage;

  String? get notificationTitle => _notificationTitle;

  String? get notificationText => _notificationText;

  String? get notificationDuration => _notificationDuration;

  String? get facebookLogin => _facebookLogin;

  String? get aboutPageId => _aboutPageId;

  String? get refundPageId => _refundPageId;

  String? get privacyPageId => _privacyPageId;

  String? get termsPageId => _termsPageId;

  String? get wpmlEnabled => _wpmlEnabled;

  String? get mvfEnabled => _mvfEnabled;

  String? get wpPointReward => _wpPointReward;

  String? get wpMultiCurrency => _wpMultiCurrency;

  String? get deliveryTracking => _deliveryTracking;

  String? get trackingUrl => _trackingUrl;

  String? get geoFencing => _geoFencing;

  // String? get oneSignalNotification => _oneSignalNotification;

  // String? get oneSignalAppId => _oneSignalAppId;

  // String? get oneSignalAppKey => _oneSignalAppKey;

  String? get privacyPage => _privacyPage;

  String? get refundPage => _refundPage;

  String? get termsPage => _termsPage;

  String? get aboutPage => _aboutPage;

  Currency? get currency => _currency;

  Language? get language => _language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['last_tab'] = _lastTab;
    map['home_style'] = _homeStyle;
    map['category_style'] = _categoryStyle;
    map['banner_style'] = _bannerStyle;
    map['card_style'] = _cardStyle;
    map['cancel_order_button'] = _cancelOrderButton;
    map['cancel_order_hours'] = _cancelOrderHours;
    map['package_name'] = _packageName;
    map['site_url'] = _siteUrl;
    map['new_product_duration'] = _newProductDuration;
    map['filter_max_price'] = _filterMaxPrice;
    map['update_order'] = _updateOrder;
    map['one_page_checkout'] = _onePageCheckout;
    map['checkout_process'] = _checkoutProcess;
    map['custom_css_for_checkout'] = _customCssForCheckout;
    map['contact_us_email'] = _contactUsEmail;
    map['from_email'] = _fromEmail;
    map['phone_no'] = _phoneNo;
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['Zip'] = _zip;
    map['Country'] = _country;
    map['Latitude'] = _latitude;
    map['Longitude'] = _longitude;
    map['sidebar_menu_icon'] = _sidebarMenuIcon;
    map['wish_list_page'] = _wishListPage;
    map['edit_profile_page'] = _editProfilePage;
    map['shipping_address_page'] = _shippingAddressPage;
    map['my_orders_page'] = _myOrdersPage;
    map['contact_us_page'] = _contactUsPage;
    map['about_us_page'] = _aboutUsPage;
    map['bill_ship_info'] = _billShipInfo;
    map['downloads'] = _downloads;
    map['news_page'] = _newsPage;
    map['intro_page'] = _introPage;
    map['share_app'] = _shareApp;
    map['rate_app'] = _rateApp;
    map['setting_page'] = _settingPage;
    map['notification_title'] = _notificationTitle;
    map['notification_text'] = _notificationText;
    map['notification_duration'] = _notificationDuration;
    map['facebook_login'] = _facebookLogin;
    map['about_page_id'] = _aboutPageId;
    map['refund_page_id'] = _refundPageId;
    map['privacy_page_id'] = _privacyPageId;
    map['terms_page_id'] = _termsPageId;
    map['wpml_enabled'] = _wpmlEnabled;
    map['mvf_enabled'] = _mvfEnabled;
    map['wp_point_reward'] = _wpPointReward;
    map['wp_multi_currency'] = _wpMultiCurrency;
    map['delivery_tracking'] = _deliveryTracking;
    map['tracking_url'] = _trackingUrl;
    map['geo_fencing'] = _geoFencing;
    // map['one_signal_notification'] = _oneSignalNotification;
    // map['one_signal_app_id'] = _oneSignalAppId;
    // map['one_signal_app_key'] = _oneSignalAppKey;
    map['privacy_page'] = _privacyPage;
    map['refund_page'] = _refundPage;
    map['terms_page'] = _termsPage;
    map['about_page'] = _aboutPage;
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    if (_language != null) {
      map['language'] = _language?.toJson();
    }
    return map;
  }

  set error(String? value) {
    _error = value;
  }

  set lastTab(String? value) {
    _lastTab = value;
  }

  set homeStyle(String? value) {
    _homeStyle = value;
  }

  set categoryStyle(String? value) {
    _categoryStyle = value;
  }

  set bannerStyle(String? value) {
    _bannerStyle = value;
  }

  set cardStyle(String? value) {
    _cardStyle = value;
  }

  set cancelOrderButton(String? value) {
    _cancelOrderButton = value;
  }

  set cancelOrderHours(String? value) {
    _cancelOrderHours = value;
  }

  set packageName(String? value) {
    _packageName = value;
  }

  set siteUrl(String? value) {
    _siteUrl = value;
  }

  set newProductDuration(String? value) {
    _newProductDuration = value;
  }

  set filterMaxPrice(String? value) {
    _filterMaxPrice = value;
  }

  set updateOrder(int? value) {
    _updateOrder = value;
  }

  set onePageCheckout(String? value) {
    _onePageCheckout = value;
  }

  set checkoutProcess(String? value) {
    _checkoutProcess = value;
  }

  set customCssForCheckout(String? value) {
    _customCssForCheckout = value;
  }

  set contactUsEmail(String? value) {
    _contactUsEmail = value;
  }

  set fromEmail(String? value) {
    _fromEmail = value;
  }

  set phoneNo(String? value) {
    _phoneNo = value;
  }

  set address(String? value) {
    _address = value;
  }

  set city(String? value) {
    _city = value;
  }

  set state(String? value) {
    _state = value;
  }

  set zip(String? value) {
    _zip = value;
  }

  set country(String? value) {
    _country = value;
  }

  set latitude(String? value) {
    _latitude = value;
  }

  set longitude(String? value) {
    _longitude = value;
  }

  set sidebarMenuIcon(String? value) {
    _sidebarMenuIcon = value;
  }

  set wishListPage(String? value) {
    _wishListPage = value;
  }

  set editProfilePage(String? value) {
    _editProfilePage = value;
  }

  set shippingAddressPage(String? value) {
    _shippingAddressPage = value;
  }

  set myOrdersPage(String? value) {
    _myOrdersPage = value;
  }

  set contactUsPage(String? value) {
    _contactUsPage = value;
  }

  set aboutUsPage(String? value) {
    _aboutUsPage = value;
  }

  set billShipInfo(String? value) {
    _billShipInfo = value;
  }

  set downloads(String? value) {
    _downloads = value;
  }

  set newsPage(String? value) {
    _newsPage = value;
  }

  set introPage(String? value) {
    _introPage = value;
  }

  set shareApp(String? value) {
    _shareApp = value;
  }

  set rateApp(String? value) {
    _rateApp = value;
  }

  set settingPage(String? value) {
    _settingPage = value;
  }

  set notificationTitle(String? value) {
    _notificationTitle = value;
  }

  set notificationText(String? value) {
    _notificationText = value;
  }

  set notificationDuration(String? value) {
    _notificationDuration = value;
  }

  set facebookLogin(String? value) {
    _facebookLogin = value;
  }

  set aboutPageId(String? value) {
    _aboutPageId = value;
  }

  set refundPageId(String? value) {
    _refundPageId = value;
  }

  set privacyPageId(String? value) {
    _privacyPageId = value;
  }

  set termsPageId(String? value) {
    _termsPageId = value;
  }

  set wpmlEnabled(String? value) {
    _wpmlEnabled = value;
  }

  set mvfEnabled(String? value) {
    _mvfEnabled = value;
  }

  set wpPointReward(String? value) {
    _wpPointReward = value;
  }

  set wpMultiCurrency(String? value) {
    _wpMultiCurrency = value;
  }

  set deliveryTracking(String? value) {
    _deliveryTracking = value;
  }

  set trackingUrl(String? value) {
    _trackingUrl = value;
  }

  set geoFencing(String? value) {
    _geoFencing = value;
  }

  // set oneSignalNotification(String? value) {
  //   _oneSignalNotification = value;
  // }

  // set oneSignalAppId(String? value) {
  //   _oneSignalAppId = value;
  // }

  // set oneSignalAppKey(String? value) {
  //   _oneSignalAppKey = value;
  // }

  set privacyPage(String? value) {
    _privacyPage = value;
  }

  set refundPage(String? value) {
    _refundPage = value;
  }

  set termsPage(String? value) {
    _termsPage = value;
  }

  set aboutPage(String? value) {
    _aboutPage = value;
  }

  set currency(Currency? value) {
    _currency = value;
  }

  set language(Language? value) {
    _language = value;
  }
}

/// code : "en"
/// id : "1"
/// native_name : "English"
/// major : "1"
/// active : "1"
/// default_locale : "en_US"
/// encode_url : "0"
/// tag : "en"
/// translated_name : "English"
/// url : "http://tcshop.androidecommerce.com"
/// country_flag_url : "https://tcshop.androidecommerce.com/wp-content/plugins/sitepress-multilingual-cms/res/flags/en.png"
/// language_code : "en"

class Language {
  Language({
    String? code,
    String? id,
    String? nativeName,
    String? major,
    String? active,
    String? defaultLocale,
    String? encodeUrl,
    String? tag,
    String? translatedName,
    String? url,
    String? countryFlagUrl,
    String? languageCode,
  }) {
    _code = code;
    _id = id;
    _nativeName = nativeName;
    _major = major;
    _active = active;
    _defaultLocale = defaultLocale;
    _encodeUrl = encodeUrl;
    _tag = tag;
    _translatedName = translatedName;
    _url = url;
    _countryFlagUrl = countryFlagUrl;
    _languageCode = languageCode;
  }

  Language.fromJson(dynamic json) {
    _code = json['code'];
    _id = json['id'];
    _nativeName = json['native_name'];
    _major = json['major'];
    _active = json['active'];
    _defaultLocale = json['default_locale'];
    _encodeUrl = json['encode_url'];
    _tag = json['tag'];
    _translatedName = json['translated_name'];
    _url = json['url'];
    _countryFlagUrl = json['country_flag_url'];
    _languageCode = json['language_code'];
  }

  String? _code;
  String? _id;
  String? _nativeName;
  String? _major;
  String? _active;
  String? _defaultLocale;
  String? _encodeUrl;
  String? _tag;
  String? _translatedName;
  String? _url;
  String? _countryFlagUrl;
  String? _languageCode;

  String? get code => _code;

  String? get id => _id;

  String? get nativeName => _nativeName;

  String? get major => _major;

  String? get active => _active;

  String? get defaultLocale => _defaultLocale;

  String? get encodeUrl => _encodeUrl;

  String? get tag => _tag;

  String? get translatedName => _translatedName;

  String? get url => _url;

  String? get countryFlagUrl => _countryFlagUrl;

  String? get languageCode => _languageCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['id'] = _id;
    map['native_name'] = _nativeName;
    map['major'] = _major;
    map['active'] = _active;
    map['default_locale'] = _defaultLocale;
    map['encode_url'] = _encodeUrl;
    map['tag'] = _tag;
    map['translated_name'] = _translatedName;
    map['url'] = _url;
    map['country_flag_url'] = _countryFlagUrl;
    map['language_code'] = _languageCode;
    return map;
  }
}

/// name : "USD"
/// position : "left"

class Currency {
  Currency({
    String? name,
    String? position,
  }) {
    _name = name;
    _position = position;
  }

  Currency.fromJson(dynamic json) {
    _name = json['name'];
    _position = json['position'];
  }

  String? _name;
  String? _position;

  String? get name => _name;

  String? get position => _position;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['position'] = _position;
    return map;
  }
}
