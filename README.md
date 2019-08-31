# FinderUtilities

![FinderUtilities logo image](https://github.com/suolapeikko/suolapeikko.github.io/blob/master/images/finderutilities_logo.png)

FinderUtilities installs a Finder Extension to your Mac, which enables you to easily launch Terminal.app to the selected directory and create empty files in Finder's folder hierarchy.

## How to install FinderUtilities
Just download the app from releses (or compile it from the sources), copy it to your /Applications directory and run it once to install the containing Finder extension. The first time you run the app, it opens up System Preferences > Extensions so that you can enable it. See the pic below:

![FinderUtilities System Preferences and Extensions](https://github.com/suolapeikko/suolapeikko.github.io/blob/master/images/finderutilities_sysprefextensions.png)

## Alternative way of installing the app extension
You can also install and remove the extension using the actual extension bundled into the app.

To install and approve the extension, run this:

`pluginkit -a FinderUtilities.app/Contents/PlugIns/RightClickExtension.appex/`

To remove it, run this:

`pluginkit -r FinderUtilities.app/Contents/PlugIns/RightClickExtension.appex/`

## How to use FinderUtilities
When you use Finder, just right click (or control click), and you'll see the following options:

![FinderUtilities Right-click](https://github.com/suolapeikko/suolapeikko.github.io/blob/master/images/finderutilities_rightclick.png)


## How to remove FinderUtilities
Kill the process (RightClickExtension), then delete the FinderUtilities.app from your computer. After this, FinderUtilities disappears from System Preferences > Extensions.

## Other useful info
The app is signed, sandboxed and notarized. It uses the following entitlements:

`com.apple.security.files.user-selected.read-write`
`com.apple.security.temporary-exception.files.home-relative-path.read-write`

The actual .app does not have a GUI, it's only functionality is to install the extension.

Deployment target has been set to macOS 10.14 Mojave.

## Links and kudos
I read Apple's App Extension Programming Guide / Finder Sync:

https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Finder.html

I also studied Janne's excellent FinderMate example:

https://github.com/jlehikoinen/FinderMate
