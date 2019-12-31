//
//  PreviewDatas.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/01/01.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation


internal let testPost = Post(userName: "Andy", imageURL: "apple.com", datas: [
    HealthData(.activeEnergyBurned, value: 200, unit: .kilocalorie()),
    HealthData(.appleStandTime, value: 7, unit: .count())
], date: Date())
