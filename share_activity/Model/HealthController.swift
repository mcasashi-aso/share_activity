//
//  HealthController.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/26.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Combine
import Foundation
import HealthKit
//import HealthKitUI

class HealthController: ObservableObject {
    
    // MARK: - Singleton
    static let shared = HealthController()
    private init() {
        self.allDatas = [
            HealthData(.activeEnergyBurned,     unit: .kilocalorie()),
            HealthData(.appleExerciseTime,      unit: .minute()),
            HealthData(.appleStandTime,         unit: .minute()),
            HealthData(.distanceWalkingRunning, unit: .meter()),
            HealthData(.stepCount,              unit: .count()),
            HealthData(.flightsClimbed,         unit: .count())
        ]
        
        askAllowHealth()
        allDatas.forEach { data in
            checkAuthorization(of: data) { success in
                if success {
                    self.datas.append(data)
                }
            }
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.loadDatas()
        }
        timer.fire()
    }
    
    private var healthStore = HKHealthStore()
    
    // MARK: -
    var allDatas = [HealthData]()
    @Published var datas = [HealthData]()
    
    var summary = HKActivitySummary()
    
    
    
    private func checkAuthorization(of healthType: HealthData, completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable(),
            let type = HKObjectType.quantityType(forIdentifier: healthType.identifier) else {
            completion(false)
            return
        }
        healthStore.requestAuthorization(toShare: nil, read: [type]) { success, _ in
            completion(success)
        }
    }
    
    func loadDatas() {
        for (index, data) in datas.enumerated() {
            var data = data
            guard let type = HKObjectType.quantityType(forIdentifier: data.identifier) else { continue }
            let predicate = HKQuery.predicateForSamples(withStart: Date.startOfToday(), end: Date())
            
            let query = HKSampleQuery(
                sampleType: type, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil
            ) { (_, results, error) in
                error.map { print($0) }
                guard let samples = results as? [HKQuantitySample] else { return }
                DispatchQueue.main.async {
                    let counts = samples.map { $0.quantity.doubleValue(for: data.unit) }
                    data.value = counts.reduce(0, +)
                    self.datas[index] = data
                }
            }
            healthStore.execute(query)
        }
    }
    
    func askAllowHealth() {
        let read: [HKObjectType] = allDatas.map {
            HKQuantityType.quantityType(forIdentifier: $0.identifier)
        }.compactMap { $0 }.map { $0 as HKObjectType }
        HKHealthStore().requestAuthorization(toShare: nil, read: Set(read)) { s, e in }
    }
    
}
