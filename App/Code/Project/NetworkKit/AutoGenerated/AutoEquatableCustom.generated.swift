// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatableCustom for classes, protocols, structs
// MARK: - BackendMultipartFileParameter AutoEquatableCustom
extension BackendMultipartFileParameter: Equatable {}
public func == (lhs: BackendMultipartFileParameter, rhs: BackendMultipartFileParameter) -> Bool {
    guard lhs.mimeType == rhs.mimeType else { return false }
    guard compareOptionals(lhs: lhs.fileName, rhs: rhs.fileName, compare: ==) else { return false }
    return true
}
// MARK: - NetworkError AutoEquatableCustom
extension NetworkError: Equatable {}
public func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    guard compareOptionals(lhs: lhs.data, rhs: rhs.data, compare: ==) else { return false }
    guard lhs.statusCode == rhs.statusCode else { return false }
    return true
}
// MARK: - ServerResponse AutoEquatableCustom
extension ServerResponse: Equatable {}
public func == (lhs: ServerResponse, rhs: ServerResponse) -> Bool {
    guard compareOptionals(lhs: lhs.data, rhs: rhs.data, compare: ==) else { return false }
    guard lhs.statusCode == rhs.statusCode else { return false }
    return true
}

// MARK: - AutoEquatableCustom for Enums
// MARK: - BackendAPIRequestParametersEncoding AutoEquatableCustom
extension BackendAPIRequestParametersEncoding: Equatable {}
public func == (lhs: BackendAPIRequestParametersEncoding, rhs: BackendAPIRequestParametersEncoding) -> Bool {
    switch (lhs, rhs) {
    case (.url, .url):
        return true

    case (.json, .json):
        return true

    default: return false
    }
}
// MARK: - BackendAPIRequestUrl AutoEquatableCustom
extension BackendAPIRequestUrl: Equatable {}
public func == (lhs: BackendAPIRequestUrl, rhs: BackendAPIRequestUrl) -> Bool {
    switch (lhs, rhs) {
    case (.endpoint(let lhs), .endpoint(let rhs)):
        return lhs == rhs

    case (.full(let lhs), .full(let rhs)):
        return lhs == rhs

    default: return false
    }
}
// MARK: - HTTPMethod AutoEquatableCustom
extension HTTPMethod: Equatable {}
public func == (lhs: HTTPMethod, rhs: HTTPMethod) -> Bool {
    switch (lhs, rhs) {
    case (.get, .get):
        return true

    case (.post, .post):
        return true

    case (.put, .put):
        return true

    case (.delete, .delete):
        return true

    default: return false
    }
}

// MARK: -
