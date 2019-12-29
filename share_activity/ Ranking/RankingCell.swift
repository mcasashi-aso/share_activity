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
    
    init(rank: Int, data: Post, count: Int) {
        self.rank = rank
        self.postData = data
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
                Image(systemName: "smallcircle.circle")
            }
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
                rank: 15, data: testPost, count: 20
            )
        }
        .previewLayout(.fixed(width: 375, height: 130))
    }
}
