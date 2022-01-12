//
//  MovieVideo.swift
//  MovieDB
//
//  Created by Rostadhi Akbar, M.Pd on 12/01/22.
//

import Foundation

public struct MovieYoutube: Codable {
    
    public init(videos: MovieVideoResponse?) {
        self.videos = videos
    }
    public let videos: MovieVideoResponse?
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
}


public struct MovieVideoResponse: Codable {
    public init(results: [MovieVideo]) {
        self.results = results
    }
    
    
    public let results: [MovieVideo]
}

public struct MovieVideo: Codable, Identifiable {
    public init(id: String, key: String, name: String, site: String) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
    }
    
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}

struct MovieResponse: Decodable {
    
    let results: [MovieYoutube]
}

extension MovieYoutube {
    
    static var stubbedMovies: [MovieYoutube] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: MovieYoutube {
        stubbedMovies[0]
    }
}
extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        
        let data = try Data(contentsOf: url)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}

