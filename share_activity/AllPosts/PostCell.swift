//
//  PostCell.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/31.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    
    var post: Post
    
    init(_ post: Post) {
        self.post = post
    }
    
    var body: some View {
        HStack {
            
            Text(post.userName)
            
            Spacer()
            
            LinkImage(URL(string: post.imageURL)) {
                ActivityRing(nil)
            }
            .frame(width: 60, height: 60)
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(testPost)
    }
}
