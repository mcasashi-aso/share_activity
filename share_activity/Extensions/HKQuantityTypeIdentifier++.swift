//
//  HKQuantityTypeIdentifier++.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/27.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation
import HealthKit

extension HKQuantityTypeIdentifier: CustomStringConvertible {
    
    
    // MARK: - For DataBase
    public var description: String {
        switch self {
        case .activeEnergyBurned:     return "activeEnergyBurned"
        case .appleExerciseTime:      return "appleExerciseTime"
        case .appleStandTime:         return "appleStandTime"
        case .distanceWalkingRunning: return "distanceWalkingRunning"
        case .stepCount:              return "stepCount"
        case .flightsClimbed:         return "flightsClimbed"
        default:                      return rawValue
        }
    }
    
    init?(from s: String) {
        switch s {
        case "activeEnergyBurned":     self = .activeEnergyBurned
        case "appleExerciseTime":      self = .appleExerciseTime
        case "appleStandTime":         self = .appleStandTime
        case "distanceWalkingRunning": self = .distanceWalkingRunning
        case "stepCount":              self = .stepCount
        case "flightsClimbed":         self = .flightsClimbed
        default:                       return nil
        }
    }
    
    var text: String {
        switch self {
        case .activeEnergyBurned:     return "Move"
        case .appleExerciseTime:      return "Exercise"
        case .appleStandTime:         return "Stand Time"
        case .distanceWalkingRunning: return "Distance"
        case .stepCount:              return "Step Count"
        case .flightsClimbed:         return "Flights Climbed"
        default:                      return rawValue
        }
    }
    
}
