import Algorithms

struct Vector: Equatable {
  let x, y, z: Double

  static func - (lhs: Vector, rhs: Vector) -> Vector {
    Vector(
      x: lhs.x - rhs.x,
      y: lhs.y - rhs.y,
      z: lhs.z - rhs.z
    )
  }

  static prefix func - (v: Vector) -> Vector {
    Vector(
      x: -v.x,
      y: -v.y,
      z: -v.z
    )
  }

  static func + (lhs: Vector, rhs: Vector) -> Vector {
    Vector(
      x: lhs.x + rhs.x,
      y: lhs.y + rhs.y,
      z: lhs.z + rhs.z
    )
  }

  static func * (factor: Double, vector: Vector) -> Vector {
    Vector(
      x: factor * vector.x,
      y: factor * vector.y,
      z: factor * vector.z
    )
  }

  var sum: Int {
    Int(x + y + z)
  }
}

extension Vector {
  init(_ input: Substring) {
    let pattern = #/\s*(-?\d+),\s+(-?\d+),\s+(-?\d+)/#
    guard let m = input.wholeMatch(of: pattern) else { fatalError() }
    x = Double(Int(m.1)!)
    y = Double(Int(m.2)!)
    z = Double(Int(m.3)!)
  }
}

infix operator +: AdditionPrecedence
infix operator -: AdditionPrecedence
infix operator *: MultiplicationPrecedence

struct Path: Equatable {
  var position: Vector
  var velocity: Vector

  func intersects(with other: Path, in range: ClosedRange<Double>) -> Bool {
    guard let intersection = intersection(with: other) else { return false }
    return range ~= intersection.x && range ~= intersection.y
  }

  func intersection(with other: Path) -> Vector? {
    let diff = other.position - self.position
    let a = self.velocity
    let b = -other.velocity

    let det = a.x * b.y - a.y * b.x
    let detA = diff.x * b.y - diff.y * b.x
    let detB = a.x * diff.y - a.y * diff.x

    guard det != 0, (detA / det) >= 0, (detB / det) >= 0 else { return nil }

    return position + (detA / det) * velocity
  }
}

extension Path {
  init(_ input: Substring) {
    position = Vector(input.split(separator: " @ ")[0])
    velocity = Vector(input.split(separator: " @ ")[1])
  }
}

func gaussianElimination(coefficients: [[Double]]) -> [Double] {
  var coefficients = coefficients
  guard !coefficients.isEmpty else { return [] }

  let rows = coefficients.count
  let cols = coefficients[0].count

  // This only works on a square matrix (with one extra column for the
  // coefficient on the right-hand side of the equation).
  assert(
    rows == cols - 1,
    "The number of coefficients on the left side of the" +
    "equation should be equal to the number of equations."
  )

  // We operate on each row in the matrix of coefficients.
  for row in coefficients.indices {
    // Normalize the row starting with the diagonal value of each row.
    let pivot = coefficients[row][row]
    for col in coefficients[row].indices {
      coefficients[row][col] /= pivot
    }

    // Sweep the other rows with `row`
    for otherRow in coefficients.indices {
      if row == otherRow { continue }

      let factor = coefficients[otherRow][row]
      for col in coefficients[otherRow].indices {
        coefficients[otherRow][col] -= factor * coefficients[row][col]
      }
    }
  }

  return coefficients.compactMap(\.last)
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

func collisionPath(of input: String) -> Path {
  let paths = input.split(separator: "\n").map(Path.init)

  let xAndY = gaussianElimination(coefficients: paths.prefix(5).windows(ofCount: 2).map {
    let (h1, h2) = ($0.first!, $0.last!)

    return [
      h2.velocity.y - h1.velocity.y,  // (dy' - dy)
      h1.velocity.x - h2.velocity.x,  // (dx - dx')
      h1.position.y - h2.position.y,  // (y - y')
      h2.position.x - h1.position.x,  // (x' - x')

      // This is the right-hand side of the equation, or
      // y*dx - x*dy -y'*dx' + x'dy'
      ((h1.position.y * h1.velocity.x)
       + (-h1.position.x * h1.velocity.y)
       + (-h2.position.y * h2.velocity.x)
       + (h2.position.x * h2.velocity.y))
    ]
  }).map { $0.rounded() }

  let z = gaussianElimination(coefficients: paths.prefix(3).windows(ofCount: 2).map {
    let (h1, h2) = ($0.first!, $0.last!)

    return [
      // This comes from:
      // (dx - dx')zR + (x' - x)dzR = z*dx - x*dz -z'*dx' + x'dz' - (dz'-dz)xR - (z - z')dxR
      h1.velocity.x - h2.velocity.x, // (dx - dx')
      h2.position.x - h1.position.x, // (x' - x)

      // This is the right-hand side again
      //  z*dx - x*dz - z'*dx' + x'dz' - (dz'-dz)xR - (z - z')dxR
      (h1.position.z  * h1.velocity.x) // z*dx
      - (h1.position.x  * h1.velocity.z) // x*dz
      - (h2.position.z  * h2.velocity.x) // z'*dx'
      + (h2.position.x  * h2.velocity.z) // x'*dz'
      - ((h2.velocity.z - h1.velocity.z) * xAndY[0]) // (dz'-dz)xR
      - ((h1.position.z  - h2.position.z)  * xAndY[2]) // (z - z')dxR
    ]
  }).map { $0.rounded() }

  // We've solved for all the necessary parameters now, return the sum!
  return Path(
    position: Vector(x: xAndY[0], y: xAndY[1], z: z[0]),
    velocity: Vector(x: xAndY[2], y: xAndY[3], z: z[1])
  )
}
