//
//  UIView++.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/29.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import UIKit

extension UIView {
    func getImageData() -> Data? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let pngData = capturedImage?.pngData()
        return pngData
    }
}
