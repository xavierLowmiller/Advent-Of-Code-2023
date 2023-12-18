public func enclosedLava(in input: String, isPart1: Bool) -> Int {
    var points = [Vector(x: 0, y: 0)]
    var borderLength: Int = 0

    if isPart1 {
        for line in input.split(separator: "\n") {
            let direction = line.split(separator: " ")[0]
            let distance = Int(line.split(separator: " ")[1])!

            points.append(distance * offsets(c: direction) + points.last!)
            borderLength += distance
        }
    } else {
        for line in input.split(separator: "\n") {
            let instruction = line.split(separator: " ")[2]
                .dropFirst(2)
                .dropLast(1)
            let direction = instruction.suffix(1)
            let distance = Int(instruction.dropLast(1), radix: 16)!

            points.append(distance * offsets(c: direction) + points.last!)
            borderLength += distance
        }
    }

    return points.amount(with: borderLength)
}

private extension [Vector] {
    func amount(with borderLength: Int) -> Int {
        // shoelace formula
        let area = zip(self, self.dropFirst()).reduce(into: 0) {
            $0 += $1.0.x * $1.1.y - $1.1.x * $1.0.y
        } / 2

        // pick's theorem
        return abs(area) - borderLength / 2 + 1 + borderLength
    }
}

struct Vector: Hashable {
    var x, y: Int

    static func + (lhs: Vector, rhs: Vector) -> Vector {
        Vector(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }

    static func * (factor: Int, vector: Vector) -> Vector {
        Vector(
            x: factor * vector.x,
            y: factor * vector.y
        )
    }
}

private func offsets(c: Substring) -> Vector {
    return switch c {
    case "R", "0": Vector(x: 1, y: 0)
    case "D", "1": Vector(x: 0, y: 1)
    case "L", "2": Vector(x: -1, y: 0)
    case "U", "3": Vector(x: 0, y: -1)
    default: Vector(x: 9999, y: 9999)
    }
}
