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
    @State var sortableBy = [HKQuantityTypeIdentifier]()
    
    @State var sortBy: HKQuantityTypeIdentifier = .activeEnergyBurned
    @State var actionSheetPresented = false
    @State var sheetPresented = false
    
    init() {
        
    }
    
    var body: some View {
        let sorted = model.rankingData.sorted { l, r in
            if let ld = l.datas.first(where: { $0.identifier == self.sortBy }),
                let rd = r.datas.first(where: { $0.identifier == self.sortBy }) {
                return ld.value.flatMap { lv in rd.value.map { rv in lv < rv } } ?? false
            } else { return false }
        }.enumerated()
        return List {
            ForEach(sorted) { post in
                NavigationLink(destination: PostView(post: post)) {
                    RankingCell(rank: sorted.firstIndex(where: { $0 == post }) ?? 0, data: post, count: sorted.count)
                }
            }
        }
        .navigationBarItems(
            leading:
            Button(action: {
                self.actionSheetPresented.toggle()
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
                    .imageScale(.large)
            }.actionSheet(isPresented: $actionSheetPresented) {
                ActionSheet(title: Text("sort by"), message: nil, buttons:
                    self.sortableBy.map { id in
                        Alert.Button.default(
                            {
                                if id == self.sortBy {
                                    return Text("☑️ " + id.description)
                                } else {
                                    return Text(id.description)
                                }
                            }()
                        ) {
                            self.sortBy = id
                        }
                        } + [.cancel()]
                )
            },
            
            trailing:
            Button(action: {
                self.sheetPresented.toggle()
            }) {
                Image(systemName: "pencil").imageScale(.large)
            }
        )
        .onAppear {
            self.sortableBy = self.model.healthController.allDatas.map { $0.identifier }
        }
        .sheet(isPresented: $sheetPresented) {
            ComposeView()
                .environmentObject(self.model)
        }
    }
}

struct Ranking_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
            .environmentObject(Model())
    }
}
