import Testing

@testable import Day24

struct Day24Tests {
  @Test func part1Example() {
    let input = """
      19, 13, 30 @ -2,  1, -2
      18, 19, 22 @ -1, -1, -2
      20, 25, 34 @ -2, -2, -4
      12, 31, 28 @ -1, -2, -1
      20, 19, 15 @  1, -5, -3
      """

    #expect(intersections(of: input, range: 7...27) == 2)
  }

  @Test func part1() {
    let range: ClosedRange<Double> = 200_000_000_000_000...400_000_000_000_000
    print("Part 1:", intersections(of: input, range: range))
  }

  @Test func part2Example() {
    let input = """
      19, 13, 30 @ -2,  1, -2
      18, 19, 22 @ -1, -1, -2
      20, 25, 34 @ -2, -2, -4
      12, 31, 28 @ -1, -2, -1
      20, 19, 15 @  1, -5, -3
      """

    #expect(collisionPath(of: input) == Path(
      position: Vector(x: 24, y: 13, z: 10),
      velocity: Vector(x: -3, y: 1, z: 2)
    ))
  }

  @Test func part2() {
    let expected = collisionPath(of: input).position.sum
    #expect(expected == 843888100572888)
    print("Part 2:", expected)
  }
}
