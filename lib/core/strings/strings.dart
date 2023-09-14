import 'package:easy_localization/easy_localization.dart';

import '../../translations/locale_keys.g.dart';

List<String> getProvinces() {
  return [
    LocaleKeys.AlAnbar.tr(),
    LocaleKeys.AlMuthanna.tr(),
    LocaleKeys.AlQadisiyah.tr(),
    LocaleKeys.AlNajaf.tr(),
    LocaleKeys.Erbil.tr(),
    LocaleKeys.AlSulaymaniyah.tr(),
    LocaleKeys.Babil.tr(),
    LocaleKeys.Baghdad.tr(),
    LocaleKeys.Basra.tr(),
    LocaleKeys.DhiQar.tr(),
    LocaleKeys.Diyala.tr(),
    LocaleKeys.Duhok.tr(),
    LocaleKeys.Karbala.tr(),
    LocaleKeys.Kirkuk.tr(),
    LocaleKeys.Maysan.tr(),
    LocaleKeys.Ninawa.tr(),
    LocaleKeys.Saladin.tr(),
    LocaleKeys.Wasit.tr(),
    LocaleKeys.Halabja.tr()
  ];
}

List<String> getPostTypes() {
  return ['private', 'public'];
}

List<String> getEventTypes() {
  return ['Wedding', 'Funeral', 'Hangout'];
}

String baseUrl = 'http://35.180.62.182';
