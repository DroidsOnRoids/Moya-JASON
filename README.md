# Moya-JASON
============

[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-JASON.svg)](https://github.com/DroidsOnRoids/Moya-JASON)

[JASON](https://github.com/delba/JASON) bindings for
[Moya](https://github.com/Moya/Moya) for easier JSON serialization with [RxSwift](https://github.com/ReactiveX/RxSwift) and [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) bindings.

# Installation

## CocoaPods

```
pod 'Moya-JASON', '~> 0.2'
```

The subspec if you want to use the bindings over RxSwift.
```
pod 'Moya-JASON/RxSwift', '~> 0.2'
```

And the subspec if you want to use the bindings over ReactiveCocoa.
```
pod 'Moya-JASON/ReactiveCocoa', '~> 0.2'
```

# Usage

Create a model struct or class. It needs to implement protocol Mappable.

### Example without handling errors while mapping

```swift
import JASON
import Moya_JASON

private extension JSONKeys {
    static let id       = JSONKey<Int>("id")
    static let language = JSONKey<String>("language")
    static let url      = JSONKey<String?>("url")
}

struct Repository: Mappable {

    let identifier: Int
    let language: String
    let url: String?

    init(_ json: JSON) throws {
        identifier  = json[.id]
        language    = json[.language]
        url         = json[.url]
    }
}
```

### Example with handling mapping errors
```swift
import JASON
import Moya_JASON

public enum UserParsingError: ErrorType {
    case Login
}

private extension JSONKeys {
    static let login = JSONKey<String>("login")
}

struct User: Mappable {

    let login: String

    init(_ json: JSON) throws {
        login = json[.login]
        if login.isEmpty {
            throw UserParsingError.Login
        }
    }
}
```

Then you have methods that extends the response from Moya. These methods are:
```swift
mapObject()
mapObject(withKeyPath:)
mapArray()
mapArray(withKeyPath:)
```

While using `mapObject()` tries to map whole response data to object,
with `mapObject(withKeyPath:)` you can specify nested object in a response to
fetch. For example `mapObject(withKeyPath: "owner")`. `RxSwift` and `ReactiveCocoa` extensions have all those methods as well.

## 1. Normal usage (without RxSwift or ReactiveCocoa)

```swift
provider = MoyaProvider<GitHub>()
provider.request(GitHub.Repos("mjacko")) { (result) in
    if case .Success(let response) = result {
        do {
            let repos: [Repository] = try response.mapArray()
            print(repos)
        } catch {
            print("There was something wrong with the mapping!")
        }
    }
}
```

## 2. RxSwift
```swift
provider = RxMoyaProvider<GitHub>()
provider
    .request(GitHub.Repo("Moya/Moya"))
    .mapObject(User.self, keyPath: "owner")
    .subscribe { event in
        switch event {
        case .Next(let user):
            print(user)
        case .Error(let error):
            print(error)
        default: break
        }
}
```

## 3. ReactiveCocoa
```swift
provider = ReactiveCocoaMoyaProvider<GitHub>()
provider
    .request(GitHub.Repos("mjacko"))
    .mapArray(Repository.self)
    .observeOn(UIScheduler())
    .start { event in
        switch event {
        case .Next(let repos):
            print(repos)
        case .Failed(let error):
            print(error)
        default: break
        }
}
```

## Author

Sunshinejr, thesunshinejr@gmail.com, <a href="https://twitter.com/thesunshinejr">@thesunshinejr</a>

## License

Moya-JASON is available under the MIT license. See the LICENSE file for more info.
