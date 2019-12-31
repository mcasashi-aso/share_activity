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
        askAllowHealth() { success in 
            self.setup()
            self.loadSummary()
        }
    }
    
    func setup() {
        self.datas = []
        allTypes.forEach { identifier, unit in
            checkAuthorization(of: identifier) { success in
                guard success else { return }
                let data = HealthData(identifier, value: 0, unit: unit)
                self.datas.append(data)
            }
        }
        loadDatas()
    }
    
    private var healthStore = HKHealthStore()
    
    // MARK: -
    var allTypes: [(HKQuantityTypeIdentifier, HKUnit)] = [
        (.activeEnergyBurned,     .kilocalorie()),
        (.appleExerciseTime,      .minute()),
        (.appleStandTime,         .minute()),
        (.distanceWalkingRunning, .meter()),
        (.stepCount,              .count()),
        (.flightsClimbed,         .count())
    ]
    @Published var datas = [HealthData]()
    
    var summary: HKActivitySummary?
    
    
    
    private func checkAuthorization(
        of typeIdentifier: HKQuantityTypeIdentifier,
        completion: @escaping (Bool) -> Void
    ) {
        guard HKHealthStore.isHealthDataAvailable(),
            let type = HKObjectType.quantityType(forIdentifier: typeIdentifier) else {
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
    
    func loadSummary() {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.day, .month, .year, .era]
        let start = calendar.date(byAdding: .day, value: -7, to: Date.startOfToday())
        var startDateComponents = calendar.dateComponents(components, from: start!)
        startDateComponents.calendar = calendar
        var endDateComponents = calendar.dateComponents(components, from: Date())
        endDateComponents.calendar = calendar
        
        let predicate = HKQuery.predicate(
            forActivitySummariesBetweenStart: startDateComponents, end: endDateComponents)
        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summaries, error) in
            if let error = error { print(error) }
            print(summaries ?? [])
            self.summary = summaries?.first
        }
        healthStore.execute(query)
    }
    
    func askAllowHealth(completion: @escaping (Bool) -> Void) {
        let read: [HKObjectType] = allTypes
            .map { id, _ in HKQuantityType.quantityType(forIdentifier: id) }
            .compactMap { $0 }
            .map { $0 as HKObjectType }
        HKHealthStore().requestAuthorization(toShare: nil, read: Set(read)) { success, error in
            if success {
                completion(success)
            } else if let error = error {
                print(error)
            }
        }
    }
    
}
