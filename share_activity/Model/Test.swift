//
//  Test.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/28.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation

//
//  PostData.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/27.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//



struct PostDataTest: Codable, Identifiable {
    
    var userName: String
    var imageURL: String
    var datas: [HealthData]
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case imageURL = "image_url"
        case datas
        case date
    }
    
    var id: String {
        "\(userName) - \(date.description)"
    }
    
}
