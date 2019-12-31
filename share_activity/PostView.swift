//
//  PostView.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/29.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import SwiftUI

struct PostView: View {
    
    var post: Post
    
    init(_ post: Post) {
        self.post = post
    }
    
    var body: some View {
        ScrollView {
            
            LinkImage(URL(string: post.imageURL)) {
                ActivityRing(nil)
            }
            .frame(width: 300, height: 300)
            
            HealthDataView(datas: post.datas)
        }
        .navigationBarTitle(post.userName)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(testPost)
    }
}
