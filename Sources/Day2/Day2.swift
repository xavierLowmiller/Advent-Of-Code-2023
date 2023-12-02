struct Game {
    var id: Int
    var rounds: [Round]

    var containsImpossibleRound: Bool {
        rounds.contains(where: { !$0.isValid })
    }

    var cubePower: Int {
        let set = rounds.minimalSetOfCubes
        return set.red * set.green * set.blue
    }

    init!(_ input: Substring) {
        guard let m = input.firstMatch(of: #/Game (\d+):(.*)\n?/#),
              let id = Int(m.output.1)
        else { return nil }

        self.id = id
        self.rounds = .init(m.output.2)
    }
}

extension Game {
    struct Round {
        var red: Int
        var green: Int
        var blue: Int

        var isValid: Bool {
            guard red <= 12 else { return false }
            guard green <= 13 else { return false }
            guard blue <= 14 else { return false }
            return true
        }

        init(_ input: Substring) {
            red = input.firstMatch(of: #/ (\d+) red/#)
                .flatMap { Int($0.output.1) } ?? 0
            green = input.firstMatch(of: #/ (\d+) green/#)
                .flatMap { Int($0.output.1) } ?? 0
            blue = input.firstMatch(of: #/ (\d+) blue/#)
                .flatMap { Int($0.output.1) } ?? 0
        }
    }
}

extension Array where Element == Game.Round {
    init(_ s: Substring) {
        self = s.split(separator: ";").map(Element.init)
    }

    var minimalSetOfCubes: (red: Int, green: Int, blue: Int) {
        reduce((0, 0, 0)) {
            (
                Swift.max($0.0, $1.red),
                Swift.max($0.1, $1.green),
                Swift.max($0.2, $1.blue)
            )
        }
    }
}

extension Collection where Element == Game {
    var sumOfPossibleIDs: Int {
        self
            .filter { !$0.containsImpossibleRound }
            .reduce(0) { $0 + $1.id }
    }

    var totalCubePower: Int {
        self.map(\.cubePower).reduce(0, +)
    }
}
