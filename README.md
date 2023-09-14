# RadioButton

<p align="center">
    <img src="https://img.shields.io/badge/platform-iOS | macOS-blue.svg?style=flat" alt="Platforms" />
    <img src="https://img.shields.io/badge/Swift-5-orange.svg" />
    <a href="https://swift.org/package-manager"><img src="https://img.shields.io/badge/SPM-Compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" /></a>
    <a href=[license-url]><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
    <a href=[user-url]=><img src="https://img.shields.io/badge/contact-@lukluca-blue.svg?style=flat"/></a>
    <a href="https://makeapullrequest.com"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square" /></a>
</p>

`RadioButton` is the missing SwiftUI Radio Button view. It uses the same approach as SwiftUI's `Picker` `radioGroup` style only available on macOS.

## 🔷 Requirements

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ macOS 10.15+  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ Xcode 11.0  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ Swift 5+  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ iOS 14+  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ tvOS 14+  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ watchOS 7+

## 🔷 Installation

`RadioButton` is available via [Swift Package Manager](https://swift.org/package-manager).

Using Xcode 11, go to `File -> Swift Packages -> Add Package Dependency` and enter [https://github.com/lukluca/RadioButton]([project-url]) 

or add manually the dependency

```swift
dependencies: [
    .package(url: "https://github.com/lukluca/RadioButton", from: "1.0.1")
]
```

## 🔷 Usage

It's very simple to use `RadioButton`, expecially with Swift's  `enum` type:

```Swift
enum City: String, CaseIterable, Identifiable {
    case milano
    case roma
    case palermo
    
    var id: RawValue {
        rawValue
    }
} 

struct ContentView: View {
    
    @State private var city = City.milano
    
    var body: some View {
        RadioButton(title: "Cities:",
                    itemTitle: \.rawValue,
                    isSelected: $city)
    }
}
```

It's a requirement that your model must implement `CaseIterable`, `Hashable` and `Identifiable` protocol.

For furter configurations, please see RadioButtonExample folder, it contains a very simple app with all the possible scenario. 

## 🔷 Last version

Last version is  `1.0.2`. This version fixes a build error on the package :sob: for tvOS. Please use this version as minimum version if your project supports tvOS.

## 🔷 Roadmap / TODOs

Version `1.0.0` of `RadioButton` contains a very limited set of features, basically no particular feature :smile:.

It could be extended by implementing the following tasks:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☘️ Add unit/UI tests;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☘️ Make view modifier to set common configuration (font, colors, etc); 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☘️ Support custom item view;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☘️ ... many other improvements.

## 🔷 Contributing

👨🏻‍🔧 Feel free to contribute to `RadioButton` by creating a pull request, following these guidelines:

1. Fork `RadioButton`
2. Create your feature branch
3. Commit your changes, along with unit tests
4. Push to the branch
5. Create pull request


## 🔷 Author

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;👨‍💻 [@lukluca]([user-url])

## 🔷 License

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;📄 `RadioButton` is available under the MIT license. See the [LICENSE]([license-url]) file for more info.


[license-url]: LICENSE
[user-url]: https://github.com/lukluca
[project-url]: https://github.com/lukluca/RadioButton
