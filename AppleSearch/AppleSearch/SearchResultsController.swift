//
//  SearchResultsController.swift
//  AppleSearch
//
//  Created by Michael Di Cesare on 10/3/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

struct StringConstance {
    fileprivate static let baseURL = "https://itunes.apple.com"
    fileprivate static let searchComponent = "search"
    fileprivate static let termKey = "term"
    fileprivate static let entityKey = "entity"
    fileprivate static let entityMusicValue = "musicTrack"
    fileprivate static let entityAppValue = "software"
}

class SearchResultsController {
    
    static func getMusicItems(searchText: String, completion: @escaping ([MusicSearchResult]) -> Void) {
        guard var baseURL = URL(string: StringConstance.baseURL) else {completion([]); return}
        baseURL.appendPathComponent(StringConstance.searchComponent)
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        else {completion([]); return}
        let searchTermQuery = URLQueryItem(name: StringConstance.termKey, value: searchText)
        let entityQuery = URLQueryItem(name: StringConstance.entityKey, value: StringConstance.entityMusicValue)
        
        components.queryItems = [searchTermQuery, entityQuery]
        
        guard let finalURL = components.url else {
            print("componets have and issue")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            guard let data = data else {
                print("no Data")
                completion([])
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let topLevelDict = try jsonDecoder.decode(MusicTopLevelDict.self, from: data)
                completion(topLevelDict.results)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
        }.resume()
        
    }
    
    static func getAppItems(searchText: String, completion: @escaping ([AppSearchResults]) -> Void) {
        guard var baseURL = URL(string: StringConstance.baseURL) else { completion([]) ; return }
        baseURL.appendPathComponent(StringConstance.searchComponent)
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {completion([]); return}
        let searchTermQuery = URLQueryItem(name: StringConstance.termKey, value: searchText)
        let entityQuery = URLQueryItem(name: StringConstance.entityKey, value: StringConstance.entityAppValue)
        
        components.queryItems = [searchTermQuery, entityQuery]
        
        guard let finalURL = components.url else {
            print("app componets have issue")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            guard let data = data else {
                print("no app data")
                completion([])
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let topLevelDict = try jsonDecoder.decode(AppTopLevelDict.self, from: data)
                completion(topLevelDict.results)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }.resume()
    }
    
    static func getMusicImageFor(item: MusicSearchResult, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLAsString = item.artworkUrl100,
            let url = URL(string: imageURLAsString) else {
                print("no image in url")
                completion(nil)
                return
            }
                    URLSession.shared.dataTask(with: url) { (data, _, error) in
                        if let error = error {
                            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                            completion(nil)
                            return
                        }
                        guard let data = data else {
                            print("no image data")
                            completion(nil)
                            return
                        }
                        
                        let image = UIImage(data: data)
                        completion(image)
                        
                    }.resume()
    }
    
    static func getAppImageFor(item: AppSearchResults, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLAsString = item.artworkUrl100,
            let url = URL(string: imageURLAsString) else {
                print("no image in url")
                completion(nil)
                return
        }
        URLSession.shared.dataTask(with: url) { (data , _, error) in
            if let error = error {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    completion(nil)
                    return
                }
                guard let data = data else {
                    print("no image data")
                    completion(nil)
                    return
                }
                
                let image = UIImage(data: data)
                completion(image)
                
            }.resume()
        }
        
} // end of class




