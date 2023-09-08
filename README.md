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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ iOS 13+  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ tvOS 13+  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✅ watchOS 6+

## 🔷 Installation

`RadioButton` is available via [Swift Package Manager](https://swift.org/package-manager).

Using Xcode 11, go to `File -> Swift Packages -> Add Package Dependency` and enter [[project-url]]([project-url]) 

or add manually the dependency

```swift
dependencies: [
    .package(url: "https://github.com/lukluca/RadioButton", from: "1.0.0")
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

## Meta

[@lukluca]([user-url])

[https://github.com/lukluca/RadioButton](https://github.com/lukluca/RadioButton)

[license-url]: LICENSE.txt
[user-url]: https://github.com/lukluca
