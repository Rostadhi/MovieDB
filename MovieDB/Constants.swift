//
//  Constants.swift
//  MovieDB
//
//  Created by Rostadhi Akbar, M.Pd on 12/01/22.
//

import Foundation

enum GenreType:String, CaseIterable {
    case Action = "Action"
    case Adventure = "Adventure"
    case Animation = "Animation"
    case Comedy = "Comedy"
    case Crime = "Crime"
    case Documentary = "Documentary"
    case Drama = "Drama"
    case Family = "Family"
    case Fantasy = "Fantasy"
    case History = "History"
    case Horror = "Horror"
    case Music = "Music"
    case Mystery = "Mystery"
    case Romance = "Romance"
    case ScienceFiction = "Science Fiction"
    case TVMovie = "TV Movie"
    case Thriller = "Thriller"
    case War = "War"
    case Western = "Western"
    
    static var allValues:[String] { return GenreType.allCases.map{ $0.rawValue } }
    
    func getGenreID() -> String {
        switch self {
        case .Action : return "28"
        case .Adventure : return "12"
        case .Animation : return "16"
        case .Comedy : return "35"
        case .Crime : return "80"
        case .Documentary : return "99"
        case .Drama : return "18"
        case .Family : return "10751"
        case .Fantasy : return "14"
        case .History : return "36"
        case .Horror : return "27"
        case .Music : return "10402"
        case .Mystery : return "9648"
        case .Romance : return "10749"
        case .ScienceFiction : return "878"
        case .TVMovie : return "10770"
        case .Thriller : return "53"
        case .War : return "10752"
        case .Western : return "37"
        }
    }
}

enum GenreCode:String, CaseIterable {
    case Action = "28"
    case Adventure = "12"
    case Animation = "16"
    case Comedy = "35"
    case Crime = "80"
    case Documentary = "99"
    case Drama = "18"
    case Family = "10751"
    case Fantasy = "14"
    case History = "36"
    case Horror = "27"
    case Music = "10402"
    case Mystery = "9648"
    case Romance = "10749"
    case ScienceFiction = "878"
    case TVMovie = "10770"
    case Thriller = "53"
    case War = "10752"
    case Western = "37"
    
    static var allValues:[String] { return GenreCode.allCases.map{ $0.rawValue } }
    
    func getGenreName() -> String {
        switch self {
        case .Action : return GenreType.Action.rawValue
        case .Adventure : return GenreType.Adventure.rawValue
        case .Animation : return GenreType.Animation.rawValue
        case .Comedy : return GenreType.Comedy.rawValue
        case .Crime : return GenreType.Crime.rawValue
        case .Documentary : return GenreType.Documentary.rawValue
        case .Drama : return GenreType.Drama.rawValue
        case .Family : return GenreType.Family.rawValue
        case .Fantasy : return GenreType.Fantasy.rawValue
        case .History : return GenreType.History.rawValue
        case .Horror : return GenreType.Horror.rawValue
        case .Music : return GenreType.Music.rawValue
        case .Mystery : return GenreType.Mystery.rawValue
        case .Romance : return GenreType.Romance.rawValue
        case .ScienceFiction : return GenreType.ScienceFiction.rawValue
        case .TVMovie : return GenreType.TVMovie.rawValue
        case .Thriller : return GenreType.Thriller.rawValue
        case .War : return GenreType.War.rawValue
        case .Western : return GenreType.Western.rawValue
        }
    }
}
