# Dekoter

---

## 0.3.0

### Feature

* `JSONSerialization` extension.
* The `Koting` protocol is split into `Dekoting` and `Enkoting`.
* Decoded object structure is simplified (a breaking change).

## 0.2.2

### Fix

* Fixed "Enkoting of array leads to incorrect result #12"

## 0.2.1

### Fix

* `UserDefaults` deletes an object if nil is saved.

## 0.2.0

### Features

* This release contains a public interface breaking change: methods to encode/decode objects are moved from the `Koting` protocol to `NSKeyedArchiver` and `NSKeyedUnarchiver` extensions.
* `UserDefaults` extension.
* Features section is added to the readme file.
* `NSKeyedArchiver` extension.
* `NSKeyedUnarchiver` extension.

## 0.1.1

### Features

* Handy `UserDefauls` extension.
* More unit tests.

## 0.1.0

### Features

* Basic functionality: a `Koting` protocol and a `Koter`.
* API is polished.
* Unit tests are added.
* Readme is done.
* Basic Travis setup is done.
* Podspec is prepared to be pushed.
* Cocoapods' statuses are added to the readme file.
* Xcode documentation is added.
