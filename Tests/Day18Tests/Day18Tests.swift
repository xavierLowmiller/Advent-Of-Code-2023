import XCTest
@testable import Day18

final class Day18Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        R 6 (#70c710)
        D 5 (#0dc571)
        L 2 (#5713f0)
        D 2 (#d2c081)
        R 2 (#59c680)
        D 2 (#411b91)
        L 5 (#8ceee2)
        U 2 (#caa173)
        L 1 (#1b58a2)
        U 2 (#caa171)
        R 2 (#7807d2)
        U 3 (#a77fa3)
        L 2 (#015232)
        U 2 (#7a21e3)
        """
        XCTAssertEqual(enclosedLava(in: input, isPart1: true), 62)
    }

    func testPart1() {
        print("Part 1:", enclosedLava(in: input, isPart1: true))
    }

    func testPart2Example() {
        let input = """
        R 6 (#70c710)
        D 5 (#0dc571)
        L 2 (#5713f0)
        D 2 (#d2c081)
        R 2 (#59c680)
        D 2 (#411b91)
        L 5 (#8ceee2)
        U 2 (#caa173)
        L 1 (#1b58a2)
        U 2 (#caa171)
        R 2 (#7807d2)
        U 3 (#a77fa3)
        L 2 (#015232)
        U 2 (#7a21e3)
        """
        XCTAssertEqual(enclosedLava(in: input, isPart1: false), 952408144115)
    }

    func testPart2() {
        print("Part 2:", enclosedLava(in: input, isPart1: false))
    }
}
