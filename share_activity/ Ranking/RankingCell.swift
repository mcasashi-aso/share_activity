//
//  RankingRow.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/28.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import SwiftUI

struct RankingCell: View {
    
    var count: Int
    var rank: Int
    var postData: Post
    
    init(_ post: Post, rank: Int, count: Int) {
        self.postData = post
        self.rank = rank
        self.count = count
    }
    
    var body: some View {
        HStack {
            Text("\(String(format: "%\(Int(floor(log(Double(count)))))d", rank))位")
                .multilineTextAlignment(.leading)
                .font(.title)
            Text(postData.userName).font(.title)
            Spacer()
            LinkImage(URL(string: postData.imageURL)) {
                ActivityRing(nil)
            }
        .frame(width: 60, height: 60)
        }
        .padding(15)
        //            .background(
        //                RoundedRectangle(cornerRadius: 25, style: .continuous)
        //                    .fill(Color.black)
        //            )
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RankingCell(
                testPost, rank: 5, count: 20
            )
        }
        .previewLayout(.fixed(width: 375, height: 130))
    }
}
