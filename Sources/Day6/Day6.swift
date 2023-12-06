import Foundation

struct Races {
    let races: [(duration: Int, record: Int)]

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        let times = lines[0].split(whereSeparator: \.isWhitespace).dropFirst().compactMap { Int($0) }
        let distances = lines[1].split(whereSeparator: \.isWhitespace).dropFirst().compactMap { Int($0) }
        races = Array(zip(times, distances))
    }

    var waysToWin: Int {
        races
            .map(waysToBeatTheRecord)
            .reduce(1, *)
    }
}

struct Race {
    let duration: Int
    let record: Int

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        duration = Int(lines[0].split(whereSeparator: \.isWhitespace).dropFirst().joined())!
        record = Int(lines[1].split(whereSeparator: \.isWhitespace).dropFirst().joined())!
    }

    var waysToWin: Int {
        waysToBeatTheRecord(duration: duration, record: record)
    }
}

private func waysToBeatTheRecord(duration: Int, record: Int) -> Int {
    return (0...duration).reduce(into: 0) { total, i in
        let remainingTime = duration - i
        let distance = i * remainingTime

        if distance > record {
            total += 1
        }
    }
}
