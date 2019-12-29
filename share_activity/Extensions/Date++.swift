//
//  Date++.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/26.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation

extension Date {
    static func startOfToday(calendar: Calendar = .current) -> Date? {
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        return calendar.date(from: components)
    }
}
