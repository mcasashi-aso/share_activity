//
//  RankingRow.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/28.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import SwiftUI
import HealthKit

struct RankingCell: View {
    
    var count: Int
    var identifier: HKQuantityTypeIdentifier
    var rank: Int
    var post: Post
    
    init(_ post: Post, type: HKQuantityTypeIdentifier, rank: Int, count: Int) {
        self.post = post
        self.identifier = type
        self.rank = rank
        self.count = count
    }
    
    var body: some View {
        let data = post.datas.first { $0.identifier == identifier }
        
        return HStack {
            Text("\(String(format: "%\(Int(floor(log(Double(count)))))d", rank))位")
                .multilineTextAlignment(.leading)
                .font(.title)
            Text(post.userName).font(.title)
            Spacer()
            
            Text((data?.value).map(Int.init)?.description ?? "--")
            Text(data?.unit.unitString ?? "")
        }
        .padding(15)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RankingCell(
                testPost, type: .activeEnergyBurned, rank: 5, count: 20
            )
        }
        .previewLayout(.fixed(width: 375, height: 130))
    }
}
