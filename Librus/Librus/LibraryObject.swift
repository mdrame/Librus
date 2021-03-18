//
//  Library.swift
//  Librus
//
//  Created by Mohammed Drame on 3/17/21.
//

import Foundation

public class LibraryObject: Codable {
    var libraryName: String
    var distanceFromUser: Double
    var libraryAddress: String
    init(name: String, distance: Double, address: String) {
        self.libraryName = name
        self.distanceFromUser = distance
        self.libraryAddress = address
    }
}
