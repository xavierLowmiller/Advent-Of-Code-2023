import XCTest
import Day22

final class Day22Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        1,0,1~1,2,1
        0,0,2~2,0,2
        0,2,3~2,2,3
        0,0,4~0,2,4
        2,0,5~2,2,5
        0,1,6~2,1,6
        1,1,8~1,1,9
        """

        XCTAssertEqual(numberOfRemovableBricks(input), 5)
    }

    func testPart1() {
        print("Part 1:", numberOfRemovableBricks(input))
    }

    func testPart2Example() {
        let input = """
        1,0,1~1,2,1
        0,0,2~2,0,2
        0,2,3~2,2,3
        0,0,4~0,2,4
        2,0,5~2,2,5
        0,1,6~2,1,6
        1,1,8~1,1,9
        """

        XCTAssertEqual(bricksThatFallAfterDisintegrating(input), 7)
    }

    func testPart2() {
        print("Part 2:", bricksThatFallAfterDisintegrating(input))
    }
}
