import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tutorials/provider/local_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLocale = Provider.of<LocaleProvider>(context).locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
         
          InkWell(
            onTap:() => _showLanguageDialog(context) ,
            child: Lottie.asset("assets/Animation - 1731404270233.json"))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1), // Duration of the animation
              child: CircleAvatar(
                key: ValueKey<String>(
                    currentLocale.languageCode), // Unique key for each flag
                radius: 90,
                backgroundColor: Colors
                    .transparent, // Optional, to ensure no background color
                child: ClipOval(
                  child: Image.network(
                    _getFlagUrl(currentLocale.languageCode),
                    fit: currentLocale.languageCode == "ar"
                        ? BoxFit.fill
                        : BoxFit.cover, // Adjust BoxFit here
                    width: 180, // Control size if needed
                    height: 180, // Control size if needed
                  ),
                ),
              ),
            ),
            Text(AppLocalizations.of(context)!.welcome,
                style: currentLocale.languageCode.toString() == 'en'
                    ? GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 25),
                      )
                    : currentLocale.languageCode.toString() == 'hi'
                        ? GoogleFonts.hind(
                            textStyle: TextStyle(fontSize: 25),
                          )
                        : GoogleFonts.notoKufiArabic(
                            textStyle: TextStyle(fontSize: 25),
                          )),
          ],
        ),
      ),
    );
  }

  String _getFlagUrl(String languageCode) {
    switch (languageCode) {
      case 'en':
        return "https://cdn.britannica.com/33/4833-050-F6E415FE/Flag-United-States-of-America.jpg";
      case 'hi':
        return "https://media.istockphoto.com/id/1309093521/vector/highly-detailed-flag-of-india-india-flag-high-detail-national-flag-india-vector-of-india.jpg?s=170667a&w=0&k=20&c=euSf7OQSKPG5hp_XRZNYZGPYyQON45yJiMSO56anNtw=";
      case 'ar':
        return "https://cdn.britannica.com/82/5782-050-8A763A9A/Flag-United-Arab-Emirates.jpg";
      default:
        return "https://cdn.britannica.com/33/4833-050-F6E415FE/Flag-United-States-of-America.jpg";
    }
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(AppLocalizations.of(context)!.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: L10n.all.map((locale) {
              final language = locale.languageCode == 'en'
                  ? 'English'
                  : locale.languageCode == 'hi'
                      ? 'हिंदी'
                      : 'عربي';
              return RadioListTile<Locale>(
                title: Text(
                  language,
                ),
                value: locale,
                groupValue: Provider.of<LocaleProvider>(context).locale,
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .setLocale(newLocale);
                  }
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
