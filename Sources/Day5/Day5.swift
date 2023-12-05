private struct Map {
    struct Section {
        let destinationRangeStart: Int
        let sourceRangeStart: Int
        let rangeLength: Int

        init!(_ input: Substring) {
            guard let m = input.firstMatch(of: #/(\d+) (\d+) (\d+)/#),
                  let i1 = Int(m.output.1),
                  let i2 = Int(m.output.2),
                  let i3 = Int(m.output.3)
            else { return nil }
            destinationRangeStart = i1
            sourceRangeStart = i2
            rangeLength = i3
        }

        func contains(_ value: Int) -> Bool {
            sourceRangeStart <= value && sourceRangeStart + rangeLength > value
        }

        var sourceRange: Range<Int> {
            sourceRangeStart..<sourceRangeStart + rangeLength
        }

        var translation: Int {
            destinationRangeStart - sourceRangeStart
        }
    }

    let name: String
    let sections: [Section]

    init(_ input: Substring) {
        let lines = input.split(separator: "\n")
        name = String(lines[0])
        sections = lines.dropFirst().map { Section($0) }
    }

    var transform: (Int) -> Int {
        { value in
            if let section = sections.first(where: { $0.contains(value) }) {
                return value + section.translation
            } else {
                return value
            }
        }
    }

    var transformRanges: ([Range<Int>]) -> [Range<Int>] {
        { ranges in
            var newRanges: [Range<Int>] = []
            for range in ranges {
                var remainingRanges: Set<Range<Int>> = [range]
                for section in sections {
                    let copy = remainingRanges
                    for range in copy where section.sourceRange.overlaps(range) {
                        remainingRanges.remove(range)
                        let overlap = range.clamped(to: section.sourceRange)

                        if range.lowerBound < overlap.lowerBound {
                            remainingRanges.insert(range.lowerBound..<overlap.lowerBound)
                        }

                        if overlap.upperBound < range.upperBound {
                            remainingRanges.insert(overlap.upperBound..<range.upperBound)
                        }

                        let newRange = (overlap.lowerBound + section.translation) ..< (overlap.upperBound + section.translation)
                        newRanges.append(newRange)
                    }
                }
                newRanges.append(contentsOf: remainingRanges)
            }
            return newRanges
        }
    }
}

struct Almanac {
    private let seeds: [Int]
    private let seedRanges: [Range<Int>]
    private let maps: [Map]

    init(_ input: String) {
        let sections = input.split(separator: "\n\n")
        seeds = parseSeeds(from: sections[0])
        seedRanges = parseSeedRanges(from: sections[0])
        maps = sections.dropFirst().map { Map($0) }
    }

    var locations: [Int] {
        seeds.map {
            var value = $0
            for f in maps.map(\.transform) {
                value = f(value)
            }
            return value
        }
    }

    var minimumByRange: Int? {
        var seedRanges = seedRanges
        for f in maps.map(\.transformRanges) {
            seedRanges = f(seedRanges)
        }
        return seedRanges.map(\.lowerBound).min()
    }
}

private func parseSeeds(from input: Substring) -> [Int] {
    return input.firstMatch(of: #/seeds: ([\d+ ]+)/#)?.output.1.split(separator: " ").compactMap { Int($0) } ?? []
}

private func parseSeedRanges(from input: Substring) -> [Range<Int>] {
    let numbers = input.firstMatch(of: #/seeds: ([\d+ ]+)/#)?.output.1.split(separator: " ").compactMap { Int($0) } ?? []

    return zip(numbers, numbers.dropFirst())
        .enumerated()
        .filter { $0.offset.isMultiple(of: 2) }
        .reduce(into: []) { (ranges, tuple) in
            let (_, (number, length)) = tuple
            ranges.append(number..<number + length)
        }
}
