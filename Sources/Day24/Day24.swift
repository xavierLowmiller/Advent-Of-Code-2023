struct Vector: Equatable {
    let x1, x2, x3: Double

    static func - (lhs: Vector, rhs: Vector) -> Vector {
        Vector(
            x1: lhs.x1 - rhs.x1,
            x2: lhs.x2 - rhs.x2,
            x3: lhs.x3 - rhs.x3
        )
    }

    static prefix func - (v: Vector) -> Vector {
        Vector(
            x1: -v.x1,
            x2: -v.x2,
            x3: -v.x3
        )
    }

    static func + (lhs: Vector, rhs: Vector) -> Vector {
        Vector(
            x1: lhs.x1 + rhs.x1,
            x2: lhs.x2 + rhs.x2,
            x3: lhs.x3 + rhs.x3
        )
    }

    static func * (factor: Double, vector: Vector) -> Vector {
        Vector(
            x1: factor * vector.x1,
            x2: factor * vector.x2,
            x3: factor * vector.x3
        )
    }
}

extension Vector {
    init(_ input: Substring) {
        guard let m = input.wholeMatch(of: #/\s*(-?\d+),\s+(-?\d+),\s+(-?\d+)/#) else { fatalError() }
        x1 = Double(Int(m.1)!)
        x2 = Double(Int(m.2)!)
        x3 = Double(Int(m.3)!)
    }
}

struct Path: Equatable {
    var position: Vector
    var velocity: Vector

    func intersects(with other: Path, in range: ClosedRange<Double>) -> Bool {

        let diff = other.position - self.position
        let a = self.velocity
        let b = -other.velocity

        let det = a.x1 * b.x2 - a.x2 * b.x1
        let detA = diff.x1 * b.x2 - diff.x2 * b.x1
        let detB = a.x1 * diff.x2 - a.x2 * diff.x1

        guard det != 0, (detA / det) >= 0, (detB / det) >= 0 else { return false }

        let intersection = position + (detA / det) * velocity

        return range ~= intersection.x1 && range ~= intersection.x2
    }
}

extension Path {
    init(_ input: Substring) {
        position = Vector(input.split(separator: " @ ")[0])
        velocity = Vector(input.split(separator: " @ ")[1])
    }
}

func intersections(of input: String, range: ClosedRange<Double>) -> Int {
    let paths = input.split(separator: "\n").map(Path.init)

    let allPairs = paths.enumerated().flatMap { offset, p in
        paths.dropFirst(offset + 1).map { (p, $0) }
    }

    assert(allPairs.count == (paths.count * (paths.count - 1)) / 2)

    return allPairs.reduce(into: 0) {
        if $1.0.intersects(with: $1.1, in: range) {
            $0 += 1
        }
    }
}

infix operator +: AdditionPrecedence
infix operator -: AdditionPrecedence
infix operator *: MultiplicationPrecedence
