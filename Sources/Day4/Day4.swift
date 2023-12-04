struct Card: Hashable, Identifiable {
    let id: UInt
    let winningNumbers: Set<UInt>
    let numbers: Set<UInt>
    let numberOfWinningNumbers: UInt

    init?(_ input: Substring) {
        guard let m = input.firstMatch(of: #/Card\s+(\d+):\s+([\d+\s+]+)\|\s+([\d+\s+]+)/#),
              let id = UInt(m.output.1)
        else { return nil }

        self.id = id
        winningNumbers = Set(m.output.2.split(omittingEmptySubsequences: true, whereSeparator: \.isWhitespace).compactMap { UInt($0) })
        numbers = Set(m.output.3.split(omittingEmptySubsequences: true, whereSeparator: \.isWhitespace).compactMap { UInt($0) })
        numberOfWinningNumbers = UInt(numbers.intersection(winningNumbers).count)
    }

    var score: UInt {
        if numberOfWinningNumbers == 0 {
            return 0
        } else {
            return 1 << (numberOfWinningNumbers - 1)
        }
    }
}

struct Cards {

    let cards: [Card]

    init(_ input: String) {
        cards = input.split(separator: "\n").compactMap(Card.init)
    }

    var totalScore: UInt {
        cards.reduce(0) { $0 + $1.score }
    }

    var numberOfTotalScratchCards: UInt {
        var numberOfCards: [Card.ID: UInt] = [:]

        for card in cards {
            let id = card.id
            let multiplier = numberOfCards[id, default: 1]
            for x in (id + 1)..<(id + 1 + card.numberOfWinningNumbers) {
                numberOfCards[x, default: 1] += multiplier
            }
        }

        return cards.map(\.id).reduce(0) {
            $0 + numberOfCards[$1, default: 1]
        }
    }
}
