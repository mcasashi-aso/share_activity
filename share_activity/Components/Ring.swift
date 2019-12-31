//
//  Ring.swift
//  Workable
//
//  Created by 麻生昌志 on 2019/07/11.
//  Copyright © 2019 麻生昌志. All rights reserved.
//

import SwiftUI

struct Ring: Shape {
    
    let width_radius: CGFloat = 1/3
    
    var value: CGFloat
    let maxValue: CGFloat
    
    var startAngle: Angle = .degrees(-90)
    var endAngle: Angle = .degrees(270)
    
    init(value: CGFloat, maxValue: CGFloat, startAngle: Angle = .degrees(-90), endAngle: Angle = .degrees(270)) {
        self.value = value <= maxValue ? value : maxValue
        self.maxValue = maxValue
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let reach = CGFloat(self.endAngle.degrees - self.startAngle.degrees)
            let angle: Angle = .degrees(Double(reach * self.value / self.maxValue)) + self.startAngle
            let center = CGPoint(x: rect.origin.x + rect.size.width / 2,
                                 y: rect.origin.y + rect.size.height / 2)
            let radius = min(rect.size.width, rect.size.height) / 2
            let width = radius * self.width_radius
            let centerRadius = radius - width / 2
            
            // 外側
            path.addArc(center: center,
                        radius: radius,
                        startAngle: self.startAngle,
                        endAngle: angle,
                        clockwise: false)
            // 先っちょ
            path.addArc(center: CGPoint(x: center.x + CGFloat(cos(angle.radians)) * centerRadius,
                                        y: center.y + CGFloat(sin(angle.radians)) * centerRadius),
                        radius: width / 2,
                        startAngle: angle,
                        endAngle: angle + Angle(radians: .pi),
                        clockwise: false)
            // 内側
            path.addArc(center: center,
                        radius: radius - width,
                        startAngle: angle,
                        endAngle: self.startAngle,
                        clockwise: true)
            // 最初の半球
            path.addArc(center: CGPoint(x: center.x + CGFloat(cos(self.startAngle.radians)) * centerRadius,
                                        y: center.y + CGFloat(sin(self.startAngle.radians)) * centerRadius),
                        radius: width / 2,
                        startAngle: Angle(radians: .pi) + self.startAngle,
                        endAngle: Angle(radians: .pi * 2) + self.startAngle,
                        clockwise: false)
            path.closeSubpath()
        }
    }
}

#if DEBUG
struct Ring_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            Ring(value: 45, maxValue: 30,
            startAngle: .degrees(-135),
            endAngle: .degrees(-45))
            Ring(value: 45, maxValue: 30,
                 startAngle: .degrees(-45),
                 endAngle: .degrees(225))
        }.previewLayout(.fixed(width: 250, height: 250))
    }
}
#endif
