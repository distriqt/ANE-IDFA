
## Migrating to v4

Version 4 changes the Google Play Services dependencies removing the dependency on the entire Ads library and replacing it with the much smaller AdsIdentifier library.

In order to support this change you will need to add the `com.distriqt.playservices.AdsIdentifier` dependency and remove the `com.distriqt.playservices.Ads`. 

Please note that other extensions may still need the `com.distriqt.playservices.Ads` extension (mainly AdMob or related services) so ensure you check your other ANEs before removing it.

