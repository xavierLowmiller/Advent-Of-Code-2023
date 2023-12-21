import SwiftUI

struct Point: Hashable {
  let x, y: Int

  var neighbors: [Point] {
    [
      Point(x: x + 1, y: y),
      Point(x: x - 1, y: y),
      Point(x: x, y: y + 1),
      Point(x: x, y: y - 1),
    ]
  }
}

typealias Bounds = (x: Int, y: Int)

struct Sheet {
  let rocks: Set<Point>
  let start: Point
  let boundaries: Bounds

  var countsForEntireSheet: [Point: Int] {
    var current: Set<Point> = [start]
    var counts: [Point: Int] = [start: 0]
    var history: (Set<Point>, Set<Point>) = ([], [])
    var stepsTaken = 0

    // If two steps ago is the same as the current one, we're in a cycle
    while history.0 != current {
      history.0 = history.1
      history.1 = current
      current = []
      stepsTaken += 1
      for point in history.1 {
        let eligibleNeighbors = point.neighbors.lazy.filter {
          0...boundaries.x ~= $0.x && 0...boundaries.y ~= $0.y && !rocks.contains($0)
        }
        for neighbor in eligibleNeighbors where counts[neighbor] == nil {
          counts[neighbor] = stepsTaken
        }
        current.formUnion(eligibleNeighbors)
      }
    }

    return counts
  }
}

private func parse(_ input: String) -> Sheet {
  var rocks: Set<Point> = []
  var start: Point?
  var maxX = 0
  var maxY = 0

  for (y, line) in input.split(separator: "\n").enumerated() {
    for (x, c) in line.enumerated() {
      switch c {
      case "#":
        rocks.insert(Point(x: x, y: y))
      case "S":
        start = Point(x: x, y: y)
      case ".":
        break
      default:
        fatalError()
      }
      maxX = max(maxX, x)
    }
    maxY = max(maxY, y)
  }

  return Sheet(rocks: rocks, start: start!, boundaries: (maxX, maxY))
}

public func possiblePositions(after steps: Int, input: String) -> Int {
  let sheet = parse(input)

  let counts = sheet.countsForEntireSheet

  let n = ((steps - ((sheet.boundaries.y + 1) / 2)) / (sheet.boundaries.y + 1))

  let boundary = n == 0 ? steps : steps % n

  let evenCorners = counts.count { _, count in count.isMultiple(of: 2) && count > boundary }
  let oddCorners = counts.count { _, count in !count.isMultiple(of: 2) && count > boundary }

  let evenFull = counts.count { _, count in count.isMultiple(of: 2) }
  let oddFull = counts.count { _, count in !count.isMultiple(of: 2) }


  return if steps.isMultiple(of: 2) {
      ((n + 1) * (n + 1)) * evenFull
    + (n * n) * oddFull
    - (n + 1) * evenCorners
    + n * oddCorners
  } else {
      ((n + 1) * (n + 1)) * oddFull
    + (n * n) * evenFull
    - (n + 1) * oddCorners
    + n * evenCorners
  }
}
