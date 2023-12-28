import XCTest
import Day25

final class Day25Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        jqt: rhn xhk nvd
        rsh: frs pzl lsr
        xhk: hfx
        cmg: qnr nvd lhk bvb
        rhn: xhk bvb hfx
        bvb: xhk hfx
        pzl: lsr hfx nvd
        qnr: nvd
        ntq: jqt hfx bvb xhk
        nvd: lhk
        lsr: lhk
        rzs: qnr cmg lsr rsh
        frs: qnr lhk lsr
        """

        XCTAssertEqual(scoreAfterDisconnectingGroups(input), 54)
    }

    func testPart1() {
        print("Part 1:", scoreAfterDisconnectingGroups(input))
    }
}
