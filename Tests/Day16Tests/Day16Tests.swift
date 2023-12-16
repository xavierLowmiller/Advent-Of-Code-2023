import XCTest
@testable import Day16

final class Day16Tests: XCTestCase {
    func testPart1Example() {
        let input = #"""
        .|...\....
        |.-.\.....
        .....|-...
        ........|.
        ..........
        .........\
        ..../.\\..
        .-.-/..|..
        .|....-|.\
        ..//.|....
        """#

        let laserArray = LaserArray(input)
        XCTAssertEqual(laserArray.energizedTiles, 46)
    }

    func testPart1() {
        let laserArray = LaserArray(input)
        print("Part 1:", laserArray.energizedTiles)
    }

    func testPart2Example() {
        let input = #"""
        .|...\....
        |.-.\.....
        .....|-...
        ........|.
        ..........
        .........\
        ..../.\\..
        .-.-/..|..
        .|....-|.\
        ..//.|....
        """#

        let laserArray = LaserArray(input)
        XCTAssertEqual(laserArray.maxEnergizedTiles, 51)
    }

    func testPart2() {
        let laserArray = LaserArray(input)
        print("Part 2:", laserArray.maxEnergizedTiles)
    }
}
