//
//  ApiCall.swift
//  MovieDB
//
//  Created by Rostadhi Akbar, M.Pd on 12/01/22.
//

import Foundation
import Alamofire
import Combine

class ApiCall:Codable {
    static let host:String = "https://api.themoviedb.org/3/"
    static let imageHost:String = "https://image.tmdb.org/t/p/w500//"
    static let headers: HTTPHeaders = [
        .accept("application/json"),
        .authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZmI1YmQ5ODdkMjU1M2Q0YjliNDBkNDhhMzkxZDJkNiIsInN1YiI6IjYxZGVkYmVkMjgxMWExMDAxOWI0NzNiYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jxfPX3uq6gKTt68LUzF5Ksxiyz6L6adMXjL2r_RTlCk")
    ]
    
    func fetchMovie(genreID: String, completion:@escaping (GenreServices) -> ()) {
        guard let url = URL(string:"\(ApiCall.host)discover/movie?with_genres=\(genreID)&include_video=true") else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        request.headers = ApiCall.headers
            
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                if let result = json["results"] {
                    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    do {
                        let movies = try! JSONDecoder().decode(GenreServices.self, from: jsonData)
                        completion(movies)
                    }catch{
                        
                        return
                    }
                }
                
            } catch {
                
                return
            }
            
        }
        .resume()
    }
    
    func fetchMovieDetail(movieID: String, completion:@escaping (MovieServices) -> ()) {
        guard let url = URL(string:"\(ApiCall.host)movie/\(movieID)") else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        request.headers = ApiCall.headers
            
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                if let result = json["results"] {
                    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    do {
                        let movies = try! JSONDecoder().decode(MovieServices.self, from: jsonData)
                        
                        #if DEBUG
                            print(result)
                        #endif
                        
                        completion(movies)
                    }catch{
                        
                        return
                    }
                }
                
            } catch {
                
                return
            }
            
        }
        .resume()
    }
    
    func fetchMovieReviews(movieID: String, completion:@escaping (ReviewServices) -> ()) {
        guard let url = URL(string:"\(ApiCall.host)movie/\(movieID)/reviews") else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        request.headers = ApiCall.headers
            
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                if let result = json["results"] {
                    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    do {
                        let reviews = try! JSONDecoder().decode(ReviewServices.self, from: jsonData)
                        
                        #if DEBUG
                            print(result)
                        #endif
                        
                        completion(reviews)
                    }catch{
                        
                        return
                    }
                }
                
            } catch {
                
                return
            }
            
        }
        .resume()
    }
}
