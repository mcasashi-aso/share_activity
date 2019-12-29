//
//  ActivityRing.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/26.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import HealthKit
import HealthKitUI
import SwiftUI

struct ActivityRing: UIViewRepresentable {
    
    var summary: HKActivitySummary?
    
    init(_ summary: HKActivitySummary?) {
        self.summary = summary
    }
    
    func makeUIView(context: Context) -> HKActivityRingView {
        HKActivityRingView()
    }
    
    func updateUIView(_ ringView: HKActivityRingView, context: Context) {
        ringView.setActivitySummary(summary, animated: true)
    }
}

struct ActivityRing_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityRing(nil)
            ActivityRing({
                let summary = HKActivitySummary()
                summary.activeEnergyBurned = HKQuantity(unit: .kilocalorie(), doubleValue: 100)
                return summary
            }())
        }
        .previewLayout(.fixed(width: 300, height: 300))
    }
}
