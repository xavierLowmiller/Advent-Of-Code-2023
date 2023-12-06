import XCTest
@testable import Day6

final class Day6Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        Time:      7  15   30
        Distance:  9  40  200
        """

        let races = Races(input)
        XCTAssertEqual(races.waysToWin, 288)
    }

    func testPart1() {
        let races = Races(input)
        XCTAssertEqual(races.waysToWin, 1108800)
        print("Part 1:", races.waysToWin)
    }

    func testPart2Example() {
        let input = """
        Time:      7  15   30
        Distance:  9  40  200
        """

        let race = Race(input)
        XCTAssertEqual(race.waysToWin, 71503)
    }

    func testPart2() {
        let race = Race(input)
        XCTAssertEqual(race.waysToWin, 36919753)
        print("Part 2:", race.waysToWin)
    }
}
