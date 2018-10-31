
## Get the Advertising Identifier

The advertising identifier is a user-specific, unique, resettable ID for advertising, provided by Google Play services and the iOS SDK. It gives users better controls and provides developers with a simple, standard system to continue to monetize your apps. It is an anonymous identifier for advertising purposes and enables users to reset their identifier or opt out of interest-based ads within Google Play and iOS apps.

- **iOS**: this is the value of the `ASIdentifierManager` `advertisingIdentifier` property - <a href="http://developer.apple.com/documentation/adsupport/asidentifiermanager">documentation</a>
- **Android**: this is the value of the Google Play Services advertising ID - <a href="http://developers.google.com/android/reference/com/google/android/gms/ads/identifier/AdvertisingIdClient">documentation</a>.


The user has the ability to limit ad tracking on both iOS and Android through the device settings. This value can also be retrieved so that you can respect this value in any tracking your application performs.


Retrieving the advertising identifier or identifier for advertising (IDFA) is an asynchronous process.

You will need to call `getIDFA()` to start the call and listen for the `IDFAEvent.COMPLETE` event. This event contains the current advertisting identifier and whether the user has limited ad tracking.


```as3
IDFA.service.addEventListener( IDFAEvent.COMPLETE, idfaCompleteHandler );
IDFA.service.getIDFA();

function idfaCompleteHandler( event:IDFAEvent ):void
{
    trace( "identifier: " + event.identifier );
    trace( "isLimitAdTrackingEnabled: " + event.isLimitAdTrackingEnabled );
}
```






