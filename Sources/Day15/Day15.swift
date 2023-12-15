extension StringProtocol {
    var holidayHash: Int {
        var value = 0
        for ascii in self.compactMap(\.asciiValue) {
            value += Int(ascii)
            value *= 17
            value %= 256
        }
        return value
    }
}

func focusingPower(of input: String) -> Int {

    struct Lens {
        let label: Substring
        var focalLength: Int
    }
    var map: [Int: [Lens]] = [:]

    for instruction in input.split(separator: ",") {

        if instruction.contains("-") {
            let label = instruction.split(separator: "-")[0]
            map[label.holidayHash]?.removeAll(where: { $0.label == label })
        } else {
            let label = instruction.split(separator: "=")[0]
            let focalLength = Int(instruction.suffix(1))!

            var list = map[label.holidayHash, default: []]
            if let index = list.firstIndex(where: { $0.label == label }) {
                list[index].focalLength = focalLength
            } else {
                list.append(Lens(label: label, focalLength: focalLength))
            }
            map[label.holidayHash] = list
        }
    }

    return map.keys.sorted().reduce(0) {
        let lenses = map[$1]!
        let factor = $1 + 1

        return $0 + lenses.enumerated().reduce(0) {
            $0 + factor * ($1.offset + 1) * $1.element.focalLength
        }
    }
}
