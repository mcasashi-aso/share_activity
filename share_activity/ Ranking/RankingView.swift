//
//  RankingView.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/27.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import HealthKit
import SwiftUI

struct RankingView: View {
    
    @EnvironmentObject var model: Model
    @State var sortableBy = HealthController.shared.datas.map { $0.identifier }
    
    @State var sortBy: HKQuantityTypeIdentifier = .activeEnergyBurned
    @State var actionSheetPresented = false
    
    var body: some View {
        
        // それなりに投稿増えたら、その日のランキングにしてもいいかもしれない
        let sorted = model.datas.sorted { l, r in
            if let ld = l.datas.first(where: { $0.identifier == self.sortBy }),
                let rd = r.datas.first(where: { $0.identifier == self.sortBy }) {
                return (ld < rd) ?? false
            } else { return false }
        }
        return List {
            ForEach(sorted) { post in
                NavigationLink(destination: PostView(post)) { () -> RankingCell in  
                    let rank = sorted.firstIndex { $0 == post } ?? 0
                    return RankingCell(post, rank: rank + 1, count: sorted.count)
                }
            }
        }
        .navigationBarItems(
            trailing:
            Button(action: {
                self.actionSheetPresented.toggle()
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
                    .imageScale(.large)
            }
        )
        .actionSheet(isPresented: $actionSheetPresented) {
            ActionSheet(title: Text("sort by"), message: nil, buttons:
                self.sortableBy.map { id in
                    Alert.Button.default(
                        {
                            if id == self.sortBy {
                                return Text("☑️ " + id.text)
                            } else {
                                return Text(id.text)
                            }
                        }()
                    ) {
                        self.sortBy = id
                    }
                } + [.cancel()]
            )
        }
        .onAppear { self.model.fetchDatas() }
    }
}

struct Ranking_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
            .environmentObject(Model())
    }
}
