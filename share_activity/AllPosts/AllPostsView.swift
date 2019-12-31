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
            ForEach(model.posts.sorted(by: >)) { post in
                NavigationLink(destination: PostView(post)) {
                    PostCell(post)
                }
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        AllPostsView()
    }
}
