// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

// MARK: - AutoHashableCustom

// MARK: - ApiMessage Hashable
extension ApiMessage: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(String(describing: title?.hashValue))",
            "\(String(describing: text?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

// MARK: - ErrorResponse Hashable
extension ErrorResponse: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(String(describing: message?.hashValue))",
            "\(statusCode.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

// MARK: - Meta Hashable
extension Meta: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(String(describing: apiVersion?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

