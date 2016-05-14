# tvProgress

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

`tvProgress` is an easy way of displaying the progress of an ongoing task on tvOS.

`tvProgress` is inspired by [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD). This library is specifically designed for tvOS and fully respects Apple design and interface guidelines regarding tvOS. It is written using Swift 2.2.

## Demo		

Try `tvProgress` with the demo project available in this repo.

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate `tvProgress` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "tvProgress/tvProgress"
```

Run `carthage update` to build the framework and drag the built `tvProgress.framework` (in Carthage/Build/tvOS folder) into your Xcode project (Linked Frameworks and Libraries in `Targets`).


### Manually

* Drag the `tvProgress.xcodeproj` file into your project.
* Add the `tvProgress` framework into `Embedded Binaries`.
* Near `Run` button, select `Manage scheme`.
* Select your app scheme.
* Click on `Edit`.
* Select `Build` on the left menu.
* Uncheck `Find Implicit Dependencies`. This will prevent Xcode from compiling library each time you compile your app.

## Usage

(see sample Xcode project in `/Demo`)

`tvProgress` is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call `tvProgress.method`).

**tvProgress usage will block the user while loading content. Use it when you need to.**

Using tvProgress is very easy. You can use it doing some very simple operations such as :

```swift
tvProgress.show()
//add your code here
tvProgress.dismiss()
```

### Showing the HUD

You can show the status of indeterminate tasks using this method:

```swift
public static func show(status: String? = .None, loaderType lt: tvLoaderType? = .None, style: tvProgressStyle? = .None, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None) -> Void
```

Each parameter is optional.
You can either :
* simply call `show()` method to display a simple animation
* specify a status to display a text
* specify a loader to change the animation using `tvLoaderType` enum
* specify a style using `tvProgressStyle` enum
* specify a closure to be executed when the user press the `Menu` button while `tvProgress` is displayed
* specify a closure to be executed when the user press the `Play/Pause` button while `tvProgress` is displayed

### Dismissing the HUD

The HUD can be dismissed using:

```swift
public static func dismiss(delay: Double = 0) -> Void
```

`Delay` parameter is optional.

### Displaying Success or Error

If your loading success or fails, you can display a message that gives information about what happened to the user.

```swift
public static func showSuccessWithStatus(status: String? = .None, andSuccessImage successImage: UIImage? = .None, andStyle style: tvProgressStyle? = .None, andAction action: (label: String, closure: (Void -> Void))? = .None, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None) -> Void
public static func showErrorWithStatus(status: String? = .None, andErrorImage errorImage: UIImage? = .None, andStyle style: tvProgressStyle? = .None, andAction action: (label: String, closure: (Void -> Void))? = .None, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None) -> Void
```

As it was for showing and dismissing `tvProgress`, each parameter is optional so that you can fully customize your success or error displaying.
Following parameters are specific to success / error display :
* You can specify an image to be displayed instead of the default image
* You can specify an `action`. This action is a tuple that contains a label and a closure. If you specify an `action`, the label will be use to generate a button while the closure will be executed when the user presses the button.

If you specify and `action`, `tvProgress` won't dismiss. You have to call the dismiss method in your closure. If you don't specify an `action`, `tvProgress` will automatically dismiss the same way [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) handles it, that means computing a display time considering the message to be displayed length or 5 seconds if no message is present.

## Customization

We just saw that customization is available in every `tvProgress` method call. You also can globally customize `tvProgress` using the following properties :

```swift

```

Each of these properties has to be called on `tvProgress.sharedInstance`

### tvProgressStyle

### tvLoaderType




### Hint

As standard `SVProgressHUD` offers two preconfigured styles:

* `SVProgressHUDStyleLight`: White background with black spinner and text
* `SVProgressHUDStyleDark`: Black background with white spinner and text

If you want to use custom colors with `setForegroundColor` and `setBackgroundColor:` don't forget to set `SVProgressHUDStyleCustom` via `setDefaultStyle:`.

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests or by [creating new issues]().

## License

`tvProgress` is distributed under the terms and conditions of the [MIT license](https://github.com/SVProgressHUD/SVProgressHUD/blob/master/LICENSE.txt). The success and error icons are made by [Freepik](http://www.freepik.com) from [Flaticon](http://www.flaticon.com) and are licensed under [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/).

## Credits

`tvProgress` is brought to you by [Cédric Eugeni](https://github.com/CedricEugeni), [Antoine Cormery](https://github.com/legomanfish) and [contributors to the project](). If you're using `tvProgress` in your project, attribution would be very appreciated.
