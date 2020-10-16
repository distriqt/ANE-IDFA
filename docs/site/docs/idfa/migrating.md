---
title: Migrating
sidebar_label: Migrating
---

## Version 5

Version 5 brings the iOS 14 authorisation requests using the App Tracking Transparency framework.

You will need to add the usage description to your info additions:

```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```

([Reference](add-the-extension))

And to ensure you have authorisation before attempting to retrieve the IDFA:

```actionscript
if (IDFA.service.authorisationStatus() == TrackingAuthorisationStatus.AUTHORISED)
{
    // You have permission to access the IDFA
}
```

[Reference](get-advertising-identifier#authorisation)



## Version 4

Version 4 changes the Google Play Services dependencies removing the dependency on the entire Ads library and replacing it with the much smaller AdsIdentifier library.

In order to support this change you will need to add the `com.distriqt.playservices.AdsIdentifier` dependency and remove the `com.distriqt.playservices.Ads`. 

Please note that other extensions may still need the `com.distriqt.playservices.Ads` extension (mainly AdMob or related services) so ensure you check your other ANEs before removing it.

