//
//  UserDefaultKeys.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/29.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation

fileprivate typealias Key = UserDefaultTypedKey

extension UserDefaultTypedKeys {
    static let userName = Key<String>("USER_NAME")
}
