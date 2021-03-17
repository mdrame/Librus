//
//  Networking.swift
//  Librus
//
//  Created by Mohammed Drame on 3/16/21.
//

import Foundation
// https://api.yelp.com/v3/businesses/search
class Networking {

     let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer o--wWs_IsfbVwOB-YYhhehTTFbSzOXMXJ3VuQCHhAGadHu2I3FTrrLvR3PBmtKL-AKswnlkkZOG9kFFN0br1DX1h6BebnLVWiljzJskfFOPjqkk1U8q_bYDwgF4NX3Yx"
    ]
    private var clientID: String =  "iU17mjNZTkTOJFiOozBnVA"
    public func getLibrary(lng: Int, lat: Int) {
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=library&location=Newark")!
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
               if let data = data, let string = String(data: data, encoding: .utf8) {
                   DispatchQueue.main.async {
                       print(string)
                   }
               }
           }
           task.resume()
    }
}
