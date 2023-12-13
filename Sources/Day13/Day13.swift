struct Patterns {
    let patterns: [Substring]

    init(_ input: String) {
        patterns = input.split(separator: "\n\n")
    }

    func reflectionSummary(maxDiff: Int) -> Int {
        patterns.reduce(0) { $0 + $1.reflectionScore(maxDiff: maxDiff) }
    }
}

extension StringProtocol {
    func reflectionScore(maxDiff: Int) -> Int {
        symmetryIndex(of: rows, maxDiff: maxDiff).map { $0 * 100 }
        ?? symmetryIndex(of: columns, maxDiff: maxDiff)
        ?? 0
    }

    var rows: [[Character]] {
        self.split(separator: "\n").map { Array($0) }
    }

    var columns: [[Character]] {
        var columns: [[Character]] = Array(repeating: [], count: rows[0].count)
        for row in rows {
            for (x, c) in row.enumerated() {
                columns[x].append(c)
            }
        }
        return columns
    }

    func symmetryIndex(of chars: [[Character]], maxDiff: Int) -> Int? {

        for index in chars.indices.dropLast() {
            let totalDifference = zip(chars[...index].reversed(), chars[(index + 1)...])
                .reduce(0) { $0 + $1.0.hammingDistance(to: $1.1) }

            if totalDifference == maxDiff {
                return index + 1
            }
        }

        return nil
    }
}

private extension [Character] {
    func hammingDistance(to other: Self) -> Int {
        zip(self, other).reduce(0) { $0 + ($1.0 == $1.1 ? 0 : 1) }
    }
}
