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
// MARK: - ApiMessage AutoEquatableCustom
extension ApiMessage: Equatable {}
public func == (lhs: ApiMessage, rhs: ApiMessage) -> Bool {
    guard compareOptionals(lhs: lhs.title, rhs: rhs.title, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.text, rhs: rhs.text, compare: ==) else { return false }
    return true
}
// MARK: - ErrorResponse AutoEquatableCustom
extension ErrorResponse: Equatable {}
public func == (lhs: ErrorResponse, rhs: ErrorResponse) -> Bool {
    guard compareOptionals(lhs: lhs.message, rhs: rhs.message, compare: ==) else { return false }
    guard lhs.statusCode == rhs.statusCode else { return false }
    return true
}
// MARK: - Meta AutoEquatableCustom
extension Meta: Equatable {}
public func == (lhs: Meta, rhs: Meta) -> Bool {
    guard compareOptionals(lhs: lhs.apiVersion, rhs: rhs.apiVersion, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatableCustom for Enums

// MARK: -
