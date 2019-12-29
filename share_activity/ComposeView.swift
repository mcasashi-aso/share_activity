//
//  ComposeView.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/29.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import SwiftUI

struct ComposeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView {
            ScrollView {
                TextField("User Name", text: $model.userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                ActivityRing(model.healthController.summary)
                    .frame(width: 300, height: 300)
                
                HealthDataView(datas: model.healthController.datas)
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(
                leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                },
                trailing:
                Button(action: {
                    self.model.post()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Post")
                }.disabled(model.userName.isEmpty)
            )
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
    }
}
