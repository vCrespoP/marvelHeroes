// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

// MARK: - AutoHashableCustom

// MARK: - Hero Hashable
extension Hero: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(String(describing: name?.hashValue))",
            "\(String(describing: photoUrl?.hashValue))",
            "\(String(describing: realName?.hashValue))",
            "\(String(describing: height?.hashValue))",
            "\(String(describing: power?.hashValue))",
            "\(String(describing: abilities?.hashValue))",
            "\(String(describing: groups?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

// MARK: - Heroes Hashable
extension Heroes: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(String(describing: list?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

