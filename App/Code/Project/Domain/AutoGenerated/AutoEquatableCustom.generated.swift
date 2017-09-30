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
// MARK: - Hero AutoEquatableCustom
extension Hero: Equatable {}
public func == (lhs: Hero, rhs: Hero) -> Bool {
    guard compareOptionals(lhs: lhs.name, rhs: rhs.name, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.photoUrl, rhs: rhs.photoUrl, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.realName, rhs: rhs.realName, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.height, rhs: rhs.height, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.power, rhs: rhs.power, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.abilities, rhs: rhs.abilities, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.groups, rhs: rhs.groups, compare: ==) else { return false }
    return true
}
// MARK: - Heroes AutoEquatableCustom
extension Heroes: Equatable {}
public func == (lhs: Heroes, rhs: Heroes) -> Bool {
    guard compareOptionals(lhs: lhs.list, rhs: rhs.list, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatableCustom for Enums

// MARK: -
