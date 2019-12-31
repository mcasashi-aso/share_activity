//
//  Model.swift
//  share_activity
//
//  Created by Masashi Aso on 2019/12/26.
//  Copyright © 2019 Masashi Aso. All rights reserved.
//

import Combine
import Foundation
import HealthKit
import HealthKitUI
import Cloudinary

//public let baseURL = URL(string: "http://172.16.102.19:32769")!
public let baseURL = URL(string: "https://share-activity.herokuapp.com")!

final class Model: ObservableObject {
    
    private var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    var healthController = HealthController.shared
    
    @UserDefault(.userName, defaultValue: "user name")
    var userName: String
    
    @Published var datas = [Post]()
    
    init() {
        
    }
    
    func post() {
        let imageData = getRingImageData(summary: healthController.summary)
        if let data = imageData {
            // cloudinary
            let config = CLDConfiguration(cloudName: "share-activity", apiKey: "996111713874317", apiSecret: "4nzRg-sEBh8TH1aEhM-d3QL0KPA")
            let cloudinary = CLDCloudinary(configuration: config)
            let params = CLDUploadRequestParams()
                .setParam("newID", value: nil)
            
            let request = cloudinary.createUploader().upload(data: data, uploadPreset: "", params: nil, progress: nil) { (result, error) in
                guard let result = result, error != nil else { print(error!); return }
                
                if let url = result.url {
                    self.postToHeroku(imageURL: url)
                }
//                self.postToHeroku(imageURL: result.url ?? "")
            }
        } else {
            postToHeroku(imageURL: "")
        }
    }
    
    private func postToHeroku(imageURL: String) {
        let post = Post(userName: userName,
                        imageURL: imageURL,
                        datas: healthController.datas,
                        date: Date())
        
        let url = baseURL.appendingPathComponent("post")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let encoded = try encoder.encode(post)
            request.httpBody = encoded
            
            URLSession.shared.dataTask(with: request) { _,_,error in
                error.map { print($0) }
                self.fetchDatas()
            }.resume()
        } catch let error {
            print(error)
        }
    }
    
    private func getRingImageData(summary: HKActivitySummary) -> Data? {
        let ringView = HKActivityRingView()
        ringView.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        ringView.activitySummary = healthController.summary
        return ringView.getImageData()
    }
    
    @objc func fetchDatas() {
        let url = baseURL.appendingPathComponent("ranking")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { print("URL session error", error!); return }
            do {
                let result = try self.decoder.decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.datas = result
                }
            } catch let error {
                print("decode error", error)
            }
            
        }.resume()
    }
}
