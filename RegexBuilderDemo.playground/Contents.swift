import RegexBuilder

let text = "  product:    Table / Price: 150"

let productReference = Reference(Substring.self)
let priceReference = Reference(Int.self)

let regex = Regex {
    "Product:"
    ZeroOrMore(.whitespace)
    Capture(as: productReference)  {
        OneOrMore(.word)
    }
    ZeroOrMore(.whitespace)
    "/"
    ZeroOrMore(.whitespace)
    "Price:"
    ZeroOrMore(.whitespace)
    TryCapture(as: priceReference) {
        OneOrMore(.digit)
    } transform: { match in
        Int(match)
    }
}.ignoresCase()

if let match = text.firstMatch(of: regex) {
    print("Product: \(match[productReference])")
    print("Price: \(match[priceReference])")
}
