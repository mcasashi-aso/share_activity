//
//  HealthType.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/27.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthType {
    static var identifier: HKQuantityTypeIdentifier { get }
    static var unit: HKUnit { get }
}

struct ActiveEnergyBurnedType: HealthType {
    static var identifier: HKQuantityTypeIdentifier = .activeEnergyBurned
    static var unit: HKUnit = .kilocalorie()
}




struct HealthData: Identifiable {
    
    var id: String {
        "\(identifier.rawValue) - \(value)"
    }
    
    let identifier: HKQuantityTypeIdentifier
    let unit: HKUnit
    
    var value: Double
    
    init(_ identifier: HKQuantityTypeIdentifier, value: Double, unit: HKUnit) {
        self.identifier = identifier
        self.unit = unit
        self.value = value
    }
}

extension HealthData: Codable {
    
    enum CodeError: Error {
        case id(string: String)
    }
    
    enum CodingKeys: String, CodingKey {
        case identifier = "type"
        case unit
        case value
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let typeString = try values.decode(String.self, forKey: .identifier)
        guard let id = HKQuantityTypeIdentifier(from: typeString) else {
            throw CodeError.id(string: typeString)
        }
        identifier = id
        
        let unitString = try values.decode(String.self, forKey: .unit)
        unit = HKUnit(from: unitString)
        
        value = try values.decode(Double.self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier.description, forKey: .identifier)
        try container.encode(unit.unitString,        forKey: .unit)
        try container.encode(value,                  forKey: .value)
    }
    
}


extension HealthData: Equatable {
    
    static func <(l: Self, r: Self) -> Bool? {
        guard l.identifier == r.identifier,
            l.unit == r.unit else { return nil }
        return l.value < r.value
    }
    
    static func >=(l: Self, r: Self) -> Bool? {
        return (l < r).map { !$0 }
    }
    
    static func >(l: Self, r: Self) -> Bool? {
        guard l.identifier == r.identifier,
            l.unit == r.unit else { return nil }
        return l.value > r.value
    }
    
    static func <=(l: Self, r: Self) -> Bool? {
        return (l > r).map { !$0 }
    }
}

