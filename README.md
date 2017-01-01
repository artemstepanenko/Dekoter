# Dekoter

[![CI Status](http://img.shields.io/travis/artemstepanenko/Dekoter.svg?style=flat)](https://travis-ci.org/artemstepanenko/Dekoter)
[![Version](https://img.shields.io/cocoapods/v/Dekoter.svg?style=flat)](http://cocoapods.org/pods/Dekoter)
[![License](https://img.shields.io/cocoapods/l/Dekoter.svg?style=flat)](http://cocoapods.org/pods/Dekoter)
[![Platform](https://img.shields.io/cocoapods/p/Dekoter.svg?style=flat)](http://cocoapods.org/pods/Dekoter)

TODO: here should be a very nice picture with cats

## Why you might be interested

Fills a gap left by the missing `NSCoding`'s support for Swift structs.
If you've ever implemented `NSCoding`, `Koting` will be familiar to you as well.

## How much familiar it feels

A quick reminder how you implement `NSCoding`:

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

Let's compare it to `Koting`:

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

Thus, not so much of differences except naming.

## Micromission

The library is small but proud of its mission, though the latter is also not that big. It's willing to serve developers as good as `NSCoding` does. Developers shouldn't feel lost and disappointing without a convenient tool to convert their Swift structs to `Data` and back.

## Why Dekoter?

You might have noticed a few cats here and there. "Kot" in some slavic languages means "cat" and sounds similar to "code".

## Collaboration

Dear, friends, your help is more than welcome!
There're multiple ways to support the project.

- Create an **issue**

if you've found a problem, or you know how to improve, or you have a question.

- Create a **pull request**

if you've developed something important previously filed as an issue.

- Send me an **email**

if you want to share your either positive or negative experience using the library and have a hard time expressing it in a form of issue. Or, maybe, you don't want to make it publicly available.

## License

It's available under the MIT license. See the LICENSE file for more info.
