//
//  ItunesResponse.swift
//  ItunesApp
//
//  Created by Juan Emilio Eguizabal on 08/06/2023.
//

import Foundation

struct ItunesResponse: Codable {
    let resultCount: Int
    let results: [ItunesItemResponse]
    
}

struct ItunesItemResponse: Codable {
    let wrapperType: String?
    let collectionType: String?
    let artistId: Int?
    let collectionId: Int?
    let amgArtistId: Int?
    let artistName: String?
    let collectionName: String?
    let collectionCensoredName: String?
    let artistViewUrl: String?
    let collectinoViewUrl: String?
    let artworkUrl60: URL?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let copyright: String?
    let country: String?
    let currency: String?
    let releaseDate: String? // TODO: Check if this parses correctly
    let primaryGenreName: String?
}
