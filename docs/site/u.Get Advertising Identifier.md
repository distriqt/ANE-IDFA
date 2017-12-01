
## Get the Advertising Identifier

Retrieving the advertising identifier or identifier for advertising (IDFA) is an asynchronous process.

You will need to call `getIDFA` to start the call and listen for the `IDFAEvent.COMPLETE` event 

```as3
IDFA.service.addEventListener( IDFAEvent.COMPLETE, idfaCompleteHandler );
IDFA.service.getIDFA();

function idfaCompleteHandler( event:IDFAEvent ):void
{
    trace( "identifier: " + event.identifier );
}
```



