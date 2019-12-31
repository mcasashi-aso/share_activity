//
//  Image++.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/28.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Image
extension Image {
    init?(data: Data) {
        if let uiImage = UIImage(data: data) {
            self = .init(uiImage: uiImage)
            return
        }else {
            return nil
        }
    }
}
