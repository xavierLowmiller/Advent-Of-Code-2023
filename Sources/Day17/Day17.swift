import AOCAlgorithms

private struct Point: Hashable {
    var x, y: Int

    func distance(to other: Point) -> Int {
        abs(x - other.x) + abs(y - other.y)
    }

    func nextSteps(
        for history: [Point],
        range: Range<Int>,
        target: Point
    ) -> Set<Point> {

        let allSteps: Set<Point> = [
            Point(x: x, y: y - 1),
            Point(x: x, y: y + 1),
            Point(x: x - 1, y: y),
            Point(x: x + 1, y: y)
        ]

        guard let last = history.last else { return allSteps }

        let diff = (x: x - last.x, y: y - last.y)

        let toCheck = history + [self]

        let streakLength = zip(toCheck, toCheck.dropFirst()).reversed()
            .map({ (x: $1.x - $0.x, y: $1.y - $0.y) })
            .prefix(while: { $0 == diff }).count

        switch streakLength {
        // Below range minimum: Continue straight
        case ..<range.lowerBound:
            let next = Point(x: x + diff.x, y: y + diff.y)
            if next == target, range.lowerBound != streakLength + 1 {
                return []
            } else {
                return [next]
            }

        // Upper end of range reached: Make turn
        case range.upperBound... where diff.x == 0:
            return Set([Point(x: x + 1, y: y), Point(x: x - 1, y: y)]).subtracting([target])
        case range.upperBound... where diff.y == 0:
            return Set([Point(x: x, y: y + 1), Point(x: x, y: y - 1)]).subtracting([target])

        // Within valid range: Continue or make turn
        default:
            var next = allSteps.subtracting([last])
            // Can only reach target if still within range
            if next.contains(target) {
                if target == Point(x: x + diff.x, y: y + diff.y) {
                    if range.lowerBound...range.upperBound ~= streakLength + 1 {
                        return next
                    } else {
                        next.remove(target)
                    }
                } else {
                    if range.lowerBound != 0 {
                        next.remove(target)
                    }
                }
            }
            return next
        }
    }
}

private struct PointAndHistory: Hashable {
    var point: Point
    var history: [Point] = []

    func possibleSteps(within validRange: Set<Point>, range: Range<Int>, target: Point) -> Set<PointAndHistory> {
        var history = history

        let next = point.nextSteps(for: history, range: range, target: target)

        if history.count == range.upperBound + 1 {
            history.removeFirst()
        }
        history.append(point)

        return Set(next
            .intersection(validRange)
            .map { PointAndHistory(point: $0, history: history) })
    }
}

public func pathOfMinimumHeatLoss(_ input: String, range: Range<Int>) -> Int {
    let values = input.split(separator: "\n").map { $0.compactMap(\.wholeNumberValue) }
    let validPoints = Set(values.indices.flatMap { y in values[y].indices.map { Point(x: $0, y: y) } })
    let start = Point(x: 0, y: 0)
    let target = Point(x: values[0].indices.max()!, y: values.indices.max()!)

    let path = aStar(
        start: PointAndHistory(point: start),
        goal: { $0.point == target },
        cost: { values[$1.point.y][$1.point.x] },
        heuristic: { target.distance(to: $0.point) },
        neighbors: { $0.possibleSteps(within: validPoints, range: range, target: target) }
    )

    return path?.dropFirst().reduce(0) { $0 + values[$1.point.y][$1.point.x] } ?? 0
}
