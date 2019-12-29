//
//  RankingDetailView.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/01/01.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import SwiftUI

struct RankingDetailView: View {
    
    var data: Post
    
    var body: some View {
        ScrollView {
            VStack {
                LinkImage(URL(string: data.imageURL)) {
                    Image(systemName: "smallcircle.circle")
                }
                
                ForEach(data.datas) { d in
                    HStack {
                        Text(d.identifier.description)
                        Spacer()
                        Text("\(d.value.map(Int.init)?.description ?? "--")\(d.unit.unitString)")
                    }
                }
            }
        }.navigationBarTitle(data.userName)
    }
}

struct RankingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RankingDetailView(data: testPost)
    }
}
