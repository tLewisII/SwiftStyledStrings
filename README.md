# SwiftStyledStrings


An easy and safe way to build attributed strings. Don't worry about remembering dictionary keys again! Also, [Monoids!](http://blog.sigfpe.com/2009/01/haskell-monoids-and-their-uses.html)

# Usage
Very simple, you have one enum, `StringAttribute`, that you work with and you simply construct values of it like so:

```swift
let fontAttr = .Font(UIFont.boldSystemFontOfSize(CGFloat(12)))
let foregroundColor = .FgColor(UIColor.redColor())

```

But that looks tedious having to create a bunch of bindings like that, so how you would do it IRL?

```swift
let attribute:StringAttribute = .Font(UIFont.boldSystemFontOfSize(CGFloat(12)))
            <> .FgColor(UIColor.redColor())
            <> .Underline(.StyleSingle)

```

Now you have an attribute built up from other attributes. If you have never seen the `<>` operator before, it is the infix operator for the `mappend` method of [Monoid](http://blog.sigfpe.com/2009/01/haskell-monoids-and-their-uses.html).

So now what do you do with this attribute? You `build` an `NSAttributedString` out of it.

```swift
let attrStr:NSAttributedString = attribute.build("This is a string.")
```

This is all nice and good, but what if you want to concatenate these strings together? You can do that as well, as `NSAttributedString` is also a Monoid.

```swift
let attributes:StringAttribute = .Font(UIFont(name: "Papyrus", size:18))
    <> .BgColor(UIColor.redColor())
    <> .FgColor(UIColor.greenColor())
    <> .Shadow(shadow)
    <> .StrikeThroughColor(UIColor.whiteColor())
    <> .StrikeThrough(NSUnderlineStyle.StyleSingle)

let moreAttributes:StringAttribute = .Font(UIFont(name: "Avenir", size:12))
    <> .BgColor(UIColor.blueColor())
    <> .FgColor(UIColor.brownColor())

attributes.build("This is a string.") <> moreAttributes.build(" And this is another string.")
```
And that is basically it. Pull requests welcome.

## License
The MIT License (MIT)
Copyright (c) 2014 Terry Lewis II

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
<br><br>
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
<br><br>
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
