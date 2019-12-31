//
//  PostData.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/27.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation

struct Post: Codable, Identifiable {
    
    var userName: String
    var imageURL: String
    var datas: [HealthData]
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case imageURL = "image_url"
        case datas
        case date
    }
    
    var id: String { "\(date.description) - \(imageURL)" }
    
}


extension Post: Comparable {
    static func < (lhs: Post, rhs: Post) -> Bool {
        lhs.date < rhs.date
    }
}
