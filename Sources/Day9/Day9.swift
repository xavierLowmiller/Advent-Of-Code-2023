struct SingleSequence {
    var values: [Int]

    private var isAllZeroes: Bool {
        values.allSatisfy { $0 == 0 }
    }

    private var subsequence: SingleSequence {
        let newValues = zip(values, values.dropFirst()).map { $1 - $0 }
        return SingleSequence(values: newValues)
    }

    var extrapolatedValue: Int {
        let subsequence = self.subsequence
        if subsequence.isAllZeroes {
            return values.last!
        } else {
            return values.last! + subsequence.extrapolatedValue
        }
    }

    var backwardsExtrapolatedValue: Int {
        let subsequence = self.subsequence

        if subsequence.isAllZeroes {
            return values.first!
        } else {
            return values.first! - subsequence.backwardsExtrapolatedValue
        }
    }
}

extension SingleSequence {
    init(_ input: Substring) {
        values = input.split(separator: " ").compactMap { Int($0) }
    }
}

struct Sequences {
    let sequences: [SingleSequence]

    init(_ input: String) {
        sequences = input.split(separator: "\n").map(SingleSequence.init)
    }

    var sumOfExtrapolatedValues: Int {
        sequences.reduce(0) {
            $0 + $1.extrapolatedValue
        }
    }

    var sumOfBackwardsExtrapolatedValues: Int {
        sequences.reduce(0) {
            $0 + $1.backwardsExtrapolatedValue
        }
    }
}
