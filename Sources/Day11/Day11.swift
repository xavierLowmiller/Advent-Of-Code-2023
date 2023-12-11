struct GalaxyMap {
    struct Point: Hashable {
        let x, y: Int
        func distance(to other: Point) -> Int {
            abs(self.x - other.x) + abs(self.y - other.y)
        }
    }

    let galaxies: Set<Point>

    init(_ input: String, increment: Int = 2) {
        let lines = input.split(separator: "\n").map(Array.init)

        var galaxies: Set<Point> = []
        var y = 0
        for line in lines {
            var x = 0
            for (index, c) in line.enumerated() {
                if c == "#" {
                    galaxies.insert(Point(x: x, y: y))
                }

                x += lines.allSatisfy({ $0[index] == "." }) ? increment : 1
            }

            y += line.allSatisfy({ $0 == "." }) ? increment : 1
        }

        self.galaxies = galaxies
    }

    var sumOfDistancesBetweenGalaxies: Int {
        let galaxies = Array(self.galaxies)

        return galaxies.enumerated().reduce(into: 0) {
            let (index, point) = $1
            for p in galaxies.dropFirst(index + 1) {
                $0 += p.distance(to: point)
            }
        }
    }
}

private extension String {
    var rows: [[Character]] {
        self.split(separator: "\n").map(Array.init)
    }
}
