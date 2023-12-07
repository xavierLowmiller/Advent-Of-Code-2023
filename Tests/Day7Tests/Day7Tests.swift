import XCTest
@testable import Day7

final class Day7Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

        let hands = Hands(input)
        XCTAssertEqual(hands.totalWinnings, 6440)
    }

    func testPart1() {
        let hands = Hands(input)
        XCTAssertEqual(hands.totalWinnings, 250946742)
        print("Part 1:", hands.totalWinnings)
    }

    func testPart2Example() {
        let input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

        let hands = Hands(input, jIsJoker: true)
        XCTAssertEqual(hands.totalWinnings, 5905)
    }

    func testPart2() {
        let hands = Hands(input, jIsJoker: true)
        XCTAssertEqual(hands.totalWinnings, 251824095)
        print("Part 2:", hands.totalWinnings)
    }

    func testHandSorting() {
        XCTAssert(Hand("T55J5") > Hand("KK677"))
        XCTAssert(Hand("KK677") < Hand("T55J5"))
        XCTAssert(Hand("QQQJA") > Hand("KTJJT"))
        XCTAssert(Hand("KTJJT") < Hand("QQQJA"))
        XCTAssert(Hand("T55J5") < Hand("QQQJA"))
        XCTAssert(Hand("QQQJA") > Hand("T55J5"))
        XCTAssert(Hand("KK677") > Hand("KTJJT"))
        XCTAssert(Hand("KTJJT") < Hand("KK677"))
        XCTAssert(Hand("32T3K") < Hand("QQQJA"))
        XCTAssert(Hand("QTQQJ") < Hand("JJJJJ"))
        XCTAssert(Hand("QTQQJ") < Hand("KTKKJ"))
        XCTAssert(Hand("QQQQJ") < Hand("KKKKQ"))
        XCTAssert(Hand("QQQQJ") < Hand("QQQQK"))
        XCTAssert(Hand("32T3K") < Hand("32Q3K"))
        XCTAssert(Hand("32T3K") < Hand("32T3A"))

        let hands = [
            "32T3K",
            "T55J5",
            "KK677",
            "KTJJT",
            "QQQJA",
        ].map { Hand($0) }

        XCTAssertEqual(hands.sorted(by: <), [
            Hand("32T3K"),
            Hand("KTJJT"),
            Hand("KK677"),
            Hand("T55J5"),
            Hand("QQQJA"),
        ])

        let hands2 = [
            "35354",
            "75858",
            "2A2AT",
            "78278",
            "2QQJ2",
            "94848",
            "JJ299",
        ].map { Hand($0) }

        XCTAssertEqual(hands2.sorted(by: <), [
            Hand("2QQJ2"),
            Hand("2A2AT"),
            Hand("35354"),
            Hand("75858"),
            Hand("78278"),
            Hand("94848"),
            Hand("JJ299"),
        ])
    }

    func testHandParsing() {
        let hands = Hands(input).hands.map(\.hand)

        let dict = Dictionary(grouping: hands) { $0.matchType }

        for (type, values) in dict {
            switch type {
            case .fiveOfAKind:
                XCTAssert(values.allSatisfy { Set($0.cards).count == 1 })
            case .fourOfAKind:
                XCTAssert(values.allSatisfy { Set($0.cards).count == 2 })
            case .fullHouse:
                XCTAssert(values.allSatisfy { Set($0.cards).count == 2 })
            case .threeOfAKind:
                XCTAssert(values.allSatisfy { Set($0.cards).count == 3 })
            case .twoPair:
                XCTAssert(values.allSatisfy { Set($0.cards).count == 3 })
            case .onePair:
                XCTAssert(values.allSatisfy { Set($0.cards).count == 4 })
            case .highCard:
                XCTAssert(values.allSatisfy { Set($0.cards).count == 5 })
            }
        }
    }
}
