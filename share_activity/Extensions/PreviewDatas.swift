//
//  PreviewDatas.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/01/01.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation


internal let testPost = Post(userName: "Andy", imageURL: "apple.com", datas: [
    {
        var data = HealthData(.activeEnergyBurned, unit: .kilocalorie())
        data.value = 200
        return data
    }(),
    {
        var data = HealthData(.appleStandTime, unit: .count())
        data.value = 7
        return data
    }()
], date: Date())
