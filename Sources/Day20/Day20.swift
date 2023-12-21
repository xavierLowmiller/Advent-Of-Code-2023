import AOCAlgorithms

enum Pulse {
    case low, high
}

struct FlipFlop: Identifiable, Equatable {
    let id: String
    var isOn: Bool = false

    mutating func receivePulse(_ pulse: Pulse) -> Pulse? {
        switch pulse {
        case .low:
            isOn.toggle()
            return isOn ? .high : .low
        case .high:
            return nil
        }
    }
}

struct Conjunction: Identifiable, Equatable {
    let id: String
    var inputs: [String: Pulse] = [:]
    var highIntervals: [String: Int] = [:]

    mutating func receivePulse(_ pulse: Pulse, from id: String, press: Int) -> Pulse? {
        inputs[id] = pulse
        if pulse == .high, highIntervals[id] == nil {
            highIntervals[id] = press
        }
        return inputs.values.allSatisfy { $0 == .high } ? .low : .high
    }
}

enum Module: Identifiable, Equatable {
    case flipFlop(FlipFlop)
    case conjunction(Conjunction)
    case other(String)

    var id: String {
        switch self {
        case .flipFlop(let flipFlop):
            return flipFlop.id
        case .conjunction(let conjunction):
            return conjunction.id
        case .other(let id):
            return id
        }
    }

    mutating func receivePulse(_ pulse: Pulse, from id: String, press: Int) -> Pulse? {
        switch self {
        case .flipFlop(var flipFlop):
            let pulse = flipFlop.receivePulse(pulse)
            self = .flipFlop(flipFlop)
            return pulse
        case .conjunction(var conjunction):
            let pulse = conjunction.receivePulse(pulse, from: id, press: press)
            self = .conjunction(conjunction)
            return pulse
        case .other:
            return nil
        }
    }
}

struct Network {

    var modules: [Module.ID: Module] = [:]
    var next: [Module.ID: [Module.ID]] = [:]

    var presses = 0
    var numberOfLowPulsesSent = 0
    var numberOfHighPulsesSent = 0

    var rxPressRound: Int?

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            var source = String(line.split(separator: " -> ")[0])
            switch source.first {
            case "%":
                source.removeFirst()
                modules[source] = .flipFlop(FlipFlop(id: source))
            case "&":
                source.removeFirst()
                modules[source] = .conjunction(Conjunction(id: source))
            default:
                modules[source] = .other(source)
            }
            next[source] = line
                .split(separator: " -> ")[1]
                .split(separator: ", ")
                .map(String.init)
        }

        for module in modules.values {
            guard case var .conjunction(conjunction) = module else { continue }
            for id in next.filter({ $0.value.contains(conjunction.id) }).keys {
                conjunction.inputs[id] = .low
            }
            modules[module.id] = .conjunction(conjunction)
        }
    }

    mutating func sendPulse() {
        presses += 1
        numberOfLowPulsesSent += 1
        var backlog: [(Pulse, from: Module.ID, to: [Module.ID])] = [
            (.low, from: "broadcaster", to: next["broadcaster"]!)
        ]
        while !backlog.isEmpty {
            let (pulse, from, ids) = backlog.removeFirst()

            for id in ids {
                switch pulse {
                case .low: numberOfLowPulsesSent += 1
                case .high: numberOfHighPulsesSent += 1
                }

                // This is the conjunction module that will send a low pulse
                // to rx. If we know the intervals, we can calculate when
                // rx will receive a pulse.
                if case let .conjunction(c) = modules[id], c.id == "rg",
                   c.inputs.count == c.highIntervals.count {
                    let values = c.highIntervals.values
                    rxPressRound = values.dropFirst().reduce(values.first!) { lcm($0, $1) }
                }

                if let pulse = modules[id]?.receivePulse(pulse, from: from, press: presses) {
                    backlog.append((pulse, from: id, to: next[id]!))
                }
            }
        }
    }
}

public func pulsesInCircuit(_ input: String, cycles: Int) -> Int {
    var network = Network(input)
    for _ in 0..<cycles {
        network.sendPulse()
    }

    return network.numberOfLowPulsesSent * network.numberOfHighPulsesSent
}

public func pressesUntilRxWasTriggered(_ input: String) -> Int {
    var network = Network(input)

    while network.rxPressRound == nil {
        network.sendPulse()
    }

    return network.rxPressRound!
}
