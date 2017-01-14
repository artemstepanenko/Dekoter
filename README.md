# Dekoter

![](https://github.com/artemstepanenko/Dekoter/blob/as/temp_cat/temp_cat.png)

[![Build Status](https://travis-ci.org/artemstepanenko/Dekoter.svg?branch=master)](https://travis-ci.org/artemstepanenko/Dekoter)
[![Version](https://img.shields.io/cocoapods/v/Dekoter.svg?style=flat)](http://cocoapods.org/pods/Dekoter)
[![License](https://img.shields.io/cocoapods/l/Dekoter.svg?style=flat)](http://cocoapods.org/pods/Dekoter)
[![Platform](https://img.shields.io/cocoapods/p/Dekoter.svg?style=flat)](http://cocoapods.org/pods/Dekoter)

- [Why You Might Be Interested](#why-you-might-be-interested)
- [How Much Familiar It Feels](#how-much-familiar-it-feels)
- [One More Example](#one-more-example)
 - [What We've Learned from It](#what-weve-learned-from-it)
- [Micromission](#micromission)
- [Why Dekoter](#why-dekoter)
- [Collaboration](#collaboration)
- [License](#license)

## Why You Might Be Interested

Fills a gap left by the missing `NSCoding`'s support for Swift structs.
If you've ever implemented `NSCoding`, `Koting` will be familiar to you as well.

## How Much Familiar It Feels

A quick reminder how to implement `NSCoding`:

```swift
class Cat: NSObject, NSCoding {

    let name: String

    init(name: String) {
        self.name = name
    }

    // MARK: - NSCoding

    private struct Key {
        static let name = "name"
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Key.name)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Key.name) as? String else {
            return nil
        }
        self.init(name: name)
    }
}
```

Let's compare it to `Koting`:

```swift
struct Cat: Koting {

    let name: String

    // MARK: - Koting

    private struct Key {
        static let name = "name"
    }

    init?(koter: Koter) {
        guard let name: String = koter.dekotObject(forKey: Key.name) else {
            return nil
        }
        self.init(name: name)
    }

    func enkot(with koter: Koter) {
        koter.enkotObject(name, forKey: Key.name)
    }
}
```

Thus, not much different besides naming.

To summarize:

- Add the `Koting` protocol to the class declaration.
- Implement `init?(koter:)` and func `enkot(with:)`.
- Done!

Once it's done, the compiler is happy, and you can convert objects to `Data` and back.

```swift
let puss = Cat(name: "Puss")
guard let data = puss.de_data else { return }
guard let againPuss = de_from(data: data) else { return }
```

## One More Example

This one is going to depict most of the Dekoter's features.

```swift
struct Cat {

    enum Sex: Int {
        case male
        case female
    }

    let name: String
    let surname: String?
    let sex: Sex
    let nationality: String
    let birthPlace: Place?

    // MARK: - Koting

    private struct Key {
        static let name = "name"
        static let surname = "surname"
        static let sex = "sex"
        static let nationality = "nationality"
        static let birthPlace = "birthPlace"
    }

    init?(koter: Koter) {
        guard let name: String = koter.dekotObject(forKey: Key.name),
            let nationality: String = koter.dekotObject(forKey: Key.nationality),
            let sexValue: Int = koter.dekotObject(forKey: Key.sex),
            let sex = Sex(rawValue: sexValue) else {

            return nil
        }
        let surname: String? = koter.dekotObject(forKey: Key.surname)
        let birthPlace: Place? = koter.dekotObject(forKey: Key.birthPlace)
        self.init(name: name, surname: surname, sex: sex, nationality: nationality, birthPlace: birthPlace)
    }

    func enkot(with koter: Koter) {
        koter.enkotObject(name, forKey: Key.name)
        koter.enkotObject(surname, forKey: Key.surname)
        koter.enkotObject(sex.rawValue, forKey: Key.sex)
        koter.enkotObject(nationality, forKey: Key.nationality)
        koter.enkotObject(birthPlace, forKey: Key.birthPlace)
    }
}
```

### What We've Learned from It

- *It's okay to have optional properties.*

As you can see, there're two optional properties. To encode them you don't do anything special, `enkotObject(_, forKey:)` takes optional as the first argument. For decoding you use `dekotObject(forKey:)` which also returns optional and it's up to you how whether you unwrap it or not.

- *`Koter` supports the same parameter types as `NSCoding` and additionally types which implement `Koting`.*

In the example above `Cat` has an optional `birthPlace` property of a type `Place`.

- *There's only one method for encoding and one – for decoding.*

Regardless the type, you use the same methods: `enkotObject(_, forKey:)` for encoding and `dekotObject(forKey:)` for decoding. These methods are generic, they derive a type based on the expected return value, that's why you should always explicitly specify it.

## Micromission

The library is small but proud of its mission, though the latter is also not that big. It's willing to serve developers as good as `NSCoding` does. Developers shouldn't feel lost and disappointed without a convenient tool to convert their Swift structs to `Data` and back.

## Why Dekoter

You might have noticed a few cats here and there. "Kot" in some slavic languages means "cat" and sounds similar to "code".

## Collaboration

Dear friends, your help is more than welcome!
There're multiple ways to support the project.

- *Create an issue.*

if you find a problem, or you know how to improve, or you have a question.

- *Create a pull request.*

if you develop something important (previously filed as an issue).

- *Send me an email.*

if you want to share your either positive or negative experience using the library and have a hard time expressing it in a form of issue. Or, maybe, you don't want to make it publicly available.

I'm always happy to read an email from you.

## License

It's available under the MIT license. See the LICENSE file for more info.
