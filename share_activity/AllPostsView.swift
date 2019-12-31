//
//  TodayView.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/31.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import SwiftUI

struct AllPostsView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        List {
            ForEach(model.datas.sorted(by: >)) { data in
                Text(data.userName)
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        AllPostsView()
    }
}
