import Testing
import Day21

@MainActor
struct Day21 {

    let testInput = """
    ...........
    .....###.#.
    .###.##..#.
    ..#.#...#..
    ....#.#....
    .##..S####.
    .##..#...#.
    .......##..
    .##.#.####.
    .##..##.##.
    ...........
    """

  @Test func part1Example() {
    #expect(possiblePositions(after: 1, input: testInput) == 2)
    #expect(possiblePositions(after: 2, input: testInput) == 4)
    #expect(possiblePositions(after: 3, input: testInput) == 6)
    #expect(possiblePositions(after: 6, input: testInput) == 16)
  }

  @Test func part1() {
    let count = possiblePositions(after: 64, input: input)
    #expect(count == 3542)
    print("Part 1:", count)
  }

  @Test func part2Example() {
//    #expect(possiblePositions(after: 6, input: testInput) == 16)
//    #expect(possiblePositions(after: 10, input: testInput) == 50)
//    #expect(possiblePositions(after: 50, input: testInput) == 1594)
//    #expect(possiblePositions(after: 100, input: testInput) == 6536)
//    #expect(possiblePositions(after: 500, input: testInput) == 167004)
//    #expect(possiblePositions(after: 1000, input: testInput) == 668697)
//    #expect(possiblePositions(after: 5000, input: testInput) == 16733044)
  }

  @Test func part2() {
    let count = possiblePositions(after: 26501365, input: input)
    #expect(count == 593174122420825)
    print("Part 2:", count)
  }
}
