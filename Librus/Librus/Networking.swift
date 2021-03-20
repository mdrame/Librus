//
//  Networking.swift
//  Librus
//
//  Created by Mohammed Drame on 3/16/21.
//

import Foundation

protocol Data {
    func getLibrary(name: String, distance: String, address: String)
}
class Networking {
    
    var protocoleData: Data!

     let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer o--wWs_IsfbVwOB-YYhhehTTFbSzOXMXJ3VuQCHhAGadHu2I3FTrrLvR3PBmtKL-AKswnlkkZOG9kFFN0br1DX1h6BebnLVWiljzJskfFOPjqkk1U8q_bYDwgF4NX3Yx"
    ]
    private var clientID: String =  "iU17mjNZTkTOJFiOozBnVA"
    public func getLibrary(lng: Double, lat: Double, completedEscapingData: @escaping ([Business]?)->Void ) {
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=library&latitude=\(lat)&longitude=\(lng)")!
        print("url➡️ \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields =  headers
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error while getting library \(error)")
                   return
               }
//               guard let httpResponse = response as? HTTPURLResponse,
//                   (200...299).contains(httpResponse.statusCode) else {
//                   print("HTTPResponse")
//                   return
//               }
            if let jsonData = data {
//                if let json = String(data: jsonData, encoding: .utf8) {
//                      print("json", json)
//                    }
                let decoder = JSONDecoder()
                do {
                    let objectData = try? decoder.decode(Welcome.self, from: jsonData)
//                    print("Library: \(objectData!.businesses)")
                    let business = objectData?.businesses
                    completedEscapingData(business)
//                    print("Networking class WelcomeDataModel: \(objectData)"
                }
            } else {
                print("There's nothing in the downloaded JSON File")
            }
            
        }
        task.resume()
}

}

