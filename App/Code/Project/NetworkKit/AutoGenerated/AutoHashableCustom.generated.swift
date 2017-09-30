// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

// MARK: - AutoHashableCustom

// MARK: - BackendMultipartFileParameter Hashable
extension BackendMultipartFileParameter: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(mimeType.hashValue)",
            "\(String(describing: fileName?.hashValue))"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

// MARK: - NetworkError Hashable
extension NetworkError: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(String(describing: data?.hashValue))",
            "\(statusCode.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

// MARK: - ServerResponse Hashable
extension ServerResponse: Hashable {

    public var hashValue: Int {
        let strings = [
            "\(String(describing: data?.hashValue))",
            "\(statusCode.hashValue)"
        ]
        let result = strings.joined(separator: ",")
        return result.hashValue
    }

}

