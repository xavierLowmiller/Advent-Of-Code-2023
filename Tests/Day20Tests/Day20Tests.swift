import XCTest
@testable import Day20

final class Day20Tests: XCTestCase {
    func testPart1Example() {
        let input1 = """
        broadcaster -> a, b, c
        %a -> b
        %b -> c
        %c -> inv
        &inv -> a
        """

        XCTAssertEqual(pulsesInCircuit(input1, cycles: 1000), 32000000)

        let input2 = """
        broadcaster -> a
        %a -> inv, con
        &inv -> b
        %b -> con
        &con -> output
        """

        XCTAssertEqual(pulsesInCircuit(input2, cycles: 1000), 11687500)
    }

    func testPart1() {
        print("Part 1:", pulsesInCircuit(input, cycles: 1000))
    }

    func testPart2() {
        print("Part 2:", pressesUntilRxWasTriggered(input))
    }
}
