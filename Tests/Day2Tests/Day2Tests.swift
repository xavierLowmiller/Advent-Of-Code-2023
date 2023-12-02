import XCTest
@testable import Day2

final class Day2Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

        let games = input.split(separator: "\n").compactMap(Game.init)
        XCTAssertEqual(games.sumOfPossibleIDs, 8)
    }

    func testPart1() {
        let games = input.split(separator: "\n").compactMap(Game.init)
        print("Part 1:", games.sumOfPossibleIDs)
    }

    func testPart2Example() {
        let input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

        let games = input.split(separator: "\n").compactMap(Game.init)
        XCTAssertEqual(games.totalCubePower, 2286)
    }

    func testPart2() {
        let games = input.split(separator: "\n").compactMap(Game.init)
        print("Part 2:", games.totalCubePower)
    }
}
