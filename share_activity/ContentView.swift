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

#warning("cameraのアクセス権消す")


struct ContentView: View {
    
    @EnvironmentObject var model: Model
    @State var sheetIsPresented = false
    
    var body: some View {
        
        ZStack {
            
            TabView {
                
                NavigationView {
                    AllPostsView()
                        .navigationBarTitle("All Posts")
                }
                .edgesIgnoringSafeArea(.top)
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("All Posts")
                    }
                }
                .onAppear { self.model.fetchDatas() }
                
                NavigationView {
                    RankingView()
                        .environmentObject(model)
                        .navigationBarTitle("Ranking")
                }
                .edgesIgnoringSafeArea(.top)
                .tabItem {
                    VStack {
                        Image(systemName: "list.number")
                        Text("Ranking")
                    }
                }
                .onAppear { self.model.fetchDatas() }
            }
            
            // FIXME: GeometryReader使うべき
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.sheetIsPresented.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 60, height: 60)
                        )
                    }
                    .padding(30)
                    .offset(x: 0, y: -54)
                    
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
                ComposeView()
                    .environmentObject(self.model)
        }
        .onAppear { self.model.healthController.loadDatas() }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
