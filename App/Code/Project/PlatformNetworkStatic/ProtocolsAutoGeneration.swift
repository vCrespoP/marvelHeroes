//
//  ProtocolsAutoGeneration.swift

import Foundation

public protocol AutoEquatable { }
public protocol AutoHashable { }
public protocol AutoCases { }
public protocol ProtocolNameMock { }
public protocol AutoDiffable { }
public protocol AutoLenses { }
public protocol AutoMapper { }

protocol AutoBuilder { }
protocol AutoHashableCustom { }
protocol AutoHashableCustom2 { }
protocol AutoEquatableCustom { }

protocol BuilderProtocol {
    typealias BuilderClosure = (inout Self) -> Void
    init(with: BuilderClosure)
}
