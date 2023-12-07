struct Hand: Comparable, CustomStringConvertible {
    let cards: [Character]
    let matchType: MatchType
    let jIsJoker: Bool

    enum MatchType: Comparable {
        case fiveOfAKind
        case fourOfAKind
        case fullHouse
        case threeOfAKind
        case twoPair
        case onePair
        case highCard
    }

    init(_ input: Substring, jIsJoker: Bool = false) {
        assert(input.count == 5)
        let cards = Array(input)
        self.cards = cards
        if cards.fiveAreEqual(jIsJoker: jIsJoker) {
            matchType = .fiveOfAKind
        } else if cards.fourAreEqual(jIsJoker: jIsJoker) {
            matchType = .fourOfAKind
        } else if cards.isFullHouse(jIsJoker: jIsJoker) {
            matchType = .fullHouse
        } else if cards.threeAreEqual(jIsJoker: jIsJoker) {
            matchType = .threeOfAKind
        } else if cards.twoPairs(jIsJoker: jIsJoker) {
            matchType = .twoPair
        } else if cards.twoAreEqual(jIsJoker: jIsJoker) {
            matchType = .onePair
        } else if cards.allAreDifferent(jIsJoker: jIsJoker) {
            matchType = .highCard
        } else {
            fatalError("Didn't match input: \(input)")
        }
        self.jIsJoker = jIsJoker
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.matchType == rhs.matchType {
            let values = camelPokerValues(jIsJoker: lhs.jIsJoker)
            return lhs.cards.map { values[$0]! } < rhs.cards.map { values[$0]! }
        } else {
            return lhs.matchType > rhs.matchType
        }
    }

    var description: String {
        String(cards)
    }
}

struct Hands {
    let hands: [(hand: Hand, bid: Int)]

    init(_ input: String, jIsJoker: Bool = false) {
        let hands = input.split(separator: "\n")
        self.hands = hands.map {
            (
                hand: Hand($0.split(separator: " ")[0], jIsJoker: jIsJoker),
                bid: Int($0.split(separator: " ")[1])!
            )
        }
    }

    var totalWinnings: Int {
        hands
            .sorted(by: { $0.hand < $1.hand })
            .map(\.bid)
            .enumerated()
            .map { ($0 + 1) * $1 }
            .reduce(0, +)
    }
}

private extension Array where Element == Character {
    private var numberOfJokers: Int {
        filter { $0 == "J" }.count
    }

    private func dict(jIsJoker: Bool) -> [Character: Int] {
        var dict = Dictionary(grouping: self) { $0 }.mapValues(\.count)
        if jIsJoker {
            dict.removeValue(forKey: "J")
            let maxKey = dict.max(by: { $0.value < $1.value })?.key ?? "J"
            dict[maxKey, default: 0] += numberOfJokers
            return dict
        } else {
            return dict
        }
    }

    func fiveAreEqual(jIsJoker: Bool) -> Bool {
        return dict(jIsJoker: jIsJoker).count == 1
    }

    func fourAreEqual(jIsJoker: Bool) -> Bool {
        let dict = self.dict(jIsJoker: jIsJoker)
        return dict.count == 2
            && dict.values.contains(where: { $0 == 4 })
            && !dict.values.contains(where: { $0 == 3 })
            && !dict.values.contains(where: { $0 == 2 })
            && dict.values.contains(where: { $0 == 1 })
    }

    func isFullHouse(jIsJoker: Bool) -> Bool {
        let dict = self.dict(jIsJoker: jIsJoker)
        return dict.count == 2
            && dict.values.contains(where: { $0 == 3 })
            && dict.values.contains(where: { $0 == 2 })
            && !dict.values.contains(where: { $0 == 1 })
    }

    func threeAreEqual(jIsJoker: Bool) -> Bool {
        let dict = self.dict(jIsJoker: jIsJoker)
        return dict.count == 3
            && dict.values.contains(where: { $0 == 3 })
            && !dict.values.contains(where: { $0 == 2 })
            && dict.values.contains(where: { $0 == 1 })
    }

    func twoPairs(jIsJoker: Bool) -> Bool {
        let dict = self.dict(jIsJoker: jIsJoker)
        return dict.count == 3
            && !dict.values.contains(where: { $0 == 3 })
            && dict.values.contains(where: { $0 == 2 })
            && dict.values.contains(where: { $0 == 1 })
    }

    func twoAreEqual(jIsJoker: Bool) -> Bool {
        let dict = self.dict(jIsJoker: jIsJoker)
        return dict.count == 4
    }

    func allAreDifferent(jIsJoker: Bool) -> Bool {
        let dict = self.dict(jIsJoker: jIsJoker)
        return dict.count == 5
    }
}

private func camelPokerValues(jIsJoker: Bool = false) -> [Character: Int] {
    [
        "A": 13,
        "K": 12,
        "Q": 11,
        "J": jIsJoker ? 0 : 10,
        "T": 9,
        "9": 8,
        "8": 7,
        "7": 6,
        "6": 5,
        "5": 4,
        "4": 3,
        "3": 2,
        "2": 1,
    ]
}

extension Array: Comparable where Element == Int {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs)
            .lazy
            .filter { $0.0 != $0.1 }
            .map { $0.0 < $0.1 }
            .first
        ?? false
    }
}
