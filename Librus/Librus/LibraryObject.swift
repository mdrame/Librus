//
//  Library.swift
//  Librus
//
//  Created by Mohammed Drame on 3/17/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
public class Welcome: Codable {
    let businesses: [Business]
    let total: Int
    let region: Region

    init(businesses: [Business], total: Int, region: Region) {
        self.businesses = businesses
        self.total = total
        self.region = region
    }
}

// MARK: - Business
public class Business: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Center
    let transactions: [String]
    let price: String?
    let location: Location
    let phone, displayPhone: String
    let distance: Double

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, coordinates, transactions, price, location, phone
        case displayPhone = "display_phone"
        case distance
    }

    init(id: String, alias: String, name: String, imageURL: String, isClosed: Bool, url: String, reviewCount: Int, categories: [Category], rating: Double, coordinates: Center, transactions: [String], price: String?, location: Location, phone: String, displayPhone: String, distance: Double) {
        self.id = id
        self.alias = alias
        self.name = name
        self.imageURL = imageURL
        self.isClosed = isClosed
        self.url = url
        self.reviewCount = reviewCount
        self.categories = categories
        self.rating = rating
        self.coordinates = coordinates
        self.transactions = transactions
        self.price = price
        self.location = location
        self.phone = phone
        self.displayPhone = displayPhone
        self.distance = distance
    }
}

// MARK: - Category
class Category: Codable {
    let alias, title: String

    init(alias: String, title: String) {
        self.alias = alias
        self.title = title
    }
}

// MARK: - Center
class Center: Codable {
    let latitude, longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: - Location
class Location: Codable {
    let address1: String
    let address2: Address2?
    let address3: Address3?
    let city: City
    let zipCode: String
    let country: Country
    let state: State
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
    }

    init(address1: String, address2: Address2?, address3: Address3?, city: City, zipCode: String, country: Country, state: State, displayAddress: [String]) {
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.city = city
        self.zipCode = zipCode
        self.country = country
        self.state = state
        self.displayAddress = displayAddress
    }
}

enum Address2: String, Codable {
    case empty = ""
    case fl6Th = "Fl 6th"
    case ste500 = "Ste 500"
}

enum Address3: String, Codable {
    case empty = ""
    case ucsfMedicalCenter = "UCSF Medical Center"
}

enum City: String, Codable {
    case sanFrancisco = "San Francisco"
}

enum Country: String, Codable {
    case us = "US"
}

enum State: String, Codable {
    case ca = "CA"
}

// MARK: - Region
class Region: Codable {
    let center: Center

    init(center: Center) {
        self.center = center
    }
}


//public class LibraryDataObject: Codable {
//    let business: [Business]
//    init(business: [Business]) {
//        self.business = business
//    }
//}
//
//public class Business: Codable {
//    var name: String
//    var coordinates: Cordinates
//    var location: Location
//    init(name: String, location: Location, coordinates: Cordinates) {
//        self.name = name
//        self.location = location
//        self.coordinates =  coordinates
//    }
//}
//
//public class Cordinates: Codable {
//    var latitude: Double
//    var longitude: Double
//    init(lati: Double, long: Double) {
//        self.latitude = lati
//        self.longitude = long
//    }
//}
//
//public class Location: Codable {
//    var address1: String
//    init(address1: String) {
//        self.address1 = address1
//    }
//}
