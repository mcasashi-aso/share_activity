//
//  ContentView.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/26.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Combine
import HealthKit
import HealthKitUI
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        TabView {
            
            NavigationView {
                RankingView()
                    .environmentObject(model)
                    .navigationBarTitle("Ranking")
            }
            .edgesIgnoringSafeArea(.all)
            .tabItem {
                VStack {
                    Image(systemName: "list.number")
                    Text("Ranking")
                }
            }.onAppear { self.model.fetchRanking() }
            
            Text("fdf")
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
