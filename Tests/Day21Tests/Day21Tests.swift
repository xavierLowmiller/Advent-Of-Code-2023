import XCTest
import Day21

final class Day21Tests: XCTestCase {
    func testPart1Example() {
        let input = """
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

        XCTAssertEqual(possiblePositions(after: 1, input: input), 2)
        XCTAssertEqual(possiblePositions(after: 2, input: input), 4)
        XCTAssertEqual(possiblePositions(after: 3, input: input), 6)
        XCTAssertEqual(possiblePositions(after: 6, input: input), 16)
    }

    func testPart1() {
        let count = possiblePositions(after: 64, input: input)
        XCTAssertEqual(count, 3542)
        print("Part 1:", count)
    }

    func testPart2Example() {}

    func testPart2() {
        print("Part 2:")
    }
}
