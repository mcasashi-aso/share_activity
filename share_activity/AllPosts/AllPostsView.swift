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
    
    @State var isLoading = false
    
    var body: some View {
        
        GeometryReader { geo in
            List {
                
                GeometryReader { g -> AnyView in
                    let threshold: CGFloat = 100
                    let panned = g.frame(in: .global).origin.y - geo.frame(in: .global).origin.y
                    if panned > threshold {
                        if !self.isLoading {
                            self.model.fetchDatas()
                        }
                        self.isLoading = true
                    } else {
                        self.isLoading = false
                    }
                    if panned > 10 {
                        return AnyView(Ring(value: panned, maxValue: threshold)
                            .opacity(Double(panned / threshold)))
                    } else {
                        return AnyView(EmptyView()
                            .frame(height: 0))
                    }
                }
                
                ForEach(self.model.posts.sorted(by: >)) { post in
                    NavigationLink(destination: PostView(post)) {
                        PostCell(post)
                    }
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
