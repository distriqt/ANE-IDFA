## Core Native Extension

This extension doesn't provide any functionality in itself but supports many of distriqt's extensions.
It is a centralised location for some common actions that can cause issues if they are implemented in
each individual extension.

There are two main purposes of this ANE:

- Manage global notifications required by multiple ANEs
- Centralise libraries to avoid conflicts and duplication

Where directed, include this ANE and you may need to call the following along with the other ANE initialisations. Check the specific extension documentation for details.

```actionscript
Core.init();
```
