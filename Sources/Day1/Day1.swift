struct Trebuchet {
    private let lines: [Substring]

    init(_ input: String) {
        lines = input.split(separator: "\n")
    }

    var calibration: Int {
        lines.reduce(into: 0) { total, line in
            let (d1, d2) = line.firstAndLastDigit
            total += d1 * 10 + d2
        }
    }

    var realCalibration: Int {
        lines.reduce(into: 0) { total, line in
            let (d1, d2) = line.firstAndLastDigitThatCouldAlsoBeSpelledOut
            total += d1 * 10 + d2
        }
    }
}

extension Substring {
    var firstAndLastDigit: (Int, Int) {
        (
            Int(String(self.first(where: \.isNumber)!))!,
            Int(String(self.last(where: \.isNumber)!))!
        )
    }

    var firstAndLastDigitThatCouldAlsoBeSpelledOut: (Int, Int) {
        return (
            number(matching: { $0.hasPrefix }, digit: \.first, shorten: { $0.removeFirst() }),
            number(matching: { $0.hasSuffix }, digit: \.last, shorten: { $0.removeLast() })
        )
    }

    private func number(
        matching predicate: (Substring) -> (Substring) -> Bool,
        digit: (Substring) -> Character?,
        shorten: (inout Substring) -> Void
    ) -> Int {
        let lookup: [Substring: Int] = [
            "one": 1,
            "two": 2,
            "three": 3,
            "four": 4,
            "five": 5,
            "six": 6,
            "seven": 7,
            "eight": 8,
            "nine": 9,
            "zero": 0,
        ]

        var s = self
        while true {
            if let key = lookup.keys.first(where: predicate(s)) {
                return lookup[key]!
            } else if let digit = digit(s)?.wholeNumberValue {
                return digit
            } else {
                shorten(&s)
            }
        }
    }
}
