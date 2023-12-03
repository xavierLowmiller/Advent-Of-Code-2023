struct Point: Hashable {
    var x: Int
    var y: Int

    var adjacentPoints: Set<Point> {
        [
            Point(x: x - 1, y: y - 1),
            Point(x: x - 1, y: y),
            Point(x: x - 1, y: y + 1),
            Point(x: x, y: y - 1),
            Point(x: x, y: y + 1),
            Point(x: x + 1, y: y - 1),
            Point(x: x + 1, y: y),
            Point(x: x + 1, y: y + 1),
        ]
    }

    func gears(in partNumbers: Set<PartNumber>) -> (PartNumber, PartNumber)? {
        let adjacentPoints = self.adjacentPoints
        let eligibleNumbers: [PartNumber] = partNumbers.filter { !$0.points.intersection(adjacentPoints).isEmpty }
        guard eligibleNumbers.count == 2 else { return nil }
        return (eligibleNumbers[0], eligibleNumbers[1])
    }
}

struct PartNumber: Hashable {
    var points: Set<Point>
    var value: Int

    func isValidPartNumber(for symbols: Set<Point>) -> Bool {
        symbols.map(\.adjacentPoints).contains { !$0.intersection(points).isEmpty }
    }
}

struct Schematic {
    var symbols: Set<Point> = []
    var gears: Set<Point> = []
    var partNumbers: Set<PartNumber> = []

    init(_ input: String) {
        for (y, line) in zip(0..., input.split(separator: "\n")) {
            var number = 0
            var coordinates: Set<Point> = []

            func resetNumber() {
                if number != 0 {
                    partNumbers.insert(PartNumber(points: coordinates, value: number))
                }
                number = 0
                coordinates = []
            }

            for (x, character) in zip(0..., line) {

                if let n = character.wholeNumberValue {
                    number *= 10
                    number += n
                    coordinates.insert(Point(x: x, y: y))
                } else {
                    resetNumber()

                    if character == "." {
                        continue
                    } else {
                        if character == "*" {
                            gears.insert(Point(x: x, y: y))
                        }
                        symbols.insert(Point(x: x, y: y))
                    }
                }
            }

            resetNumber()
        }
    }

    var sumOfEngineParts: Int {
        partNumbers
            .filter { $0.isValidPartNumber(for: symbols) }
            .reduce(0) { $0 + $1.value }
    }

    var sumOfGearRatios: Int {
        gears
            .compactMap { $0.gears(in: partNumbers) }
            .reduce(0) { $0 + $1.0.value * $1.1.value }
    }
}
