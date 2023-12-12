import XCTest
@testable import Day12

final class Day12Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        ???.### 1,1,3
        .??..??...?##. 1,1,3
        ?#?#?#?#?#?#?#? 1,3,1,6
        ????.#...#... 4,1,1
        ????.######..#####. 1,6,5
        ?###???????? 3,2,1
        """

        XCTAssertEqual("???.### 1,1,3".possibleArrangements(), 1)
        XCTAssertEqual(".??..??...?##. 1,1,3".possibleArrangements(), 4)
        XCTAssertEqual("?#?#?#?#?#?#?#? 1,3,1,6".possibleArrangements(), 1)
        XCTAssertEqual("????.#...#... 4,1,1".possibleArrangements(), 1)
        XCTAssertEqual("????.######..#####. 1,6,5".possibleArrangements(), 4)
        XCTAssertEqual("?###???????? 3,2,1".possibleArrangements(), 10)

        let arrangements = input.possibleArrangements()
        XCTAssertEqual(arrangements, 21)
    }

    func testPart1() {
        let arrangements = input.possibleArrangements()
        print("Part 1:", arrangements)
    }

    func testPart2Example() {
        let input = """
        ???.### 1,1,3
        .??..??...?##. 1,1,3
        ?#?#?#?#?#?#?#? 1,3,1,6
        ????.#...#... 4,1,1
        ????.######..#####. 1,6,5
        ?###???????? 3,2,1
        """

        XCTAssertEqual("???.### 1,1,3".possibleArrangements(repetitions: 5), 1)
        XCTAssertEqual(".??..??...?##. 1,1,3".possibleArrangements(repetitions: 5), 16384)
        XCTAssertEqual("?#?#?#?#?#?#?#? 1,3,1,6".possibleArrangements(repetitions: 5), 1)
        XCTAssertEqual("????.#...#... 4,1,1".possibleArrangements(repetitions: 5), 16)
        XCTAssertEqual("????.######..#####. 1,6,5".possibleArrangements(repetitions: 5), 2500)
        XCTAssertEqual("?###???????? 3,2,1".possibleArrangements(repetitions: 5), 506250)

        let arrangements = input.possibleArrangements(repetitions: 5)
        XCTAssertEqual(arrangements, 525152)
    }

    func testPart2() {
        let arrangements = input.possibleArrangements(repetitions: 5)
        print("Part 2:", arrangements)
    }
}
