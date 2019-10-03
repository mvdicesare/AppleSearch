//
//  SearchResult.swift
//  AppleSearch
//
//  Created by Michael Di Cesare on 10/3/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation


struct MusicTopLevelDict: Decodable {
    let results: [MusicSearchResult]
}
struct AppTopLevelDict: Decodable {
    let results: [AppSearchResults]
}
struct MusicSearchResult: Decodable {
    let artistName: String
    let trackName: String?
    let artworkUrl100: String?
}

struct AppSearchResults: Decodable {
    let trackName: String
    let description: String
    let artworkUrl100: String?
    
}
