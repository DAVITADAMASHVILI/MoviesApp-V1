//
//  MovieServiceManager.swift
//  MoviesApp
//
//  Created by DATA on 10/12/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import Foundation
import CoreData

class MovieServiceManager {
    public static let basePosterUrl = "https://image.tmdb.org/t/p/"
    
    static func fetchTop(page: Int,completion: @escaping ([Hit])->()){
        let webService = WebServiceManager.shared
        
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(webService.apiKey)&language=en-US&page=\(page)"
        
        webService.get(url: url) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                completion(movieResponse.hits)
            case .failure(_):
                print("no data found")
            }
        }
    }
    
    static func fetchPopular(page: Int,completion: @escaping ([Hit])->()) {
        let webService = WebServiceManager.shared
        
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(webService.apiKey)&language=en-US&page=\(page))"
        
        webService.get(url: url) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                completion(movieResponse.hits)
            case .failure(_):
                print("no data found")
            }
        }
        
    }
    
    static func fetchCast(id: Int,completion: @escaping ([Cast])->()) {
        let webService = WebServiceManager.shared
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(webService.apiKey)"
        
        webService.get(url: url) { (result: Result<CastResponse, Error>) in
            switch result {
            case .success(let castResponse):
                completion(castResponse.cast)
            case .failure(_):
                print("no data found")
            }
        }
        
    }
    
    static func fetchSimilar(id: Int,completion: @escaping ([Hit])->()) {
        let webService = WebServiceManager.shared
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(webService.apiKey)"
        
        webService.get(url: url) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let similarResponse):
                completion(similarResponse.hits)
            case .failure(_):
                print("no data found")
            }
        }
        
    }
    
    static func fetchDetails(id: Int,completion: @escaping (DetailsResponse)->()) {
        let webService = WebServiceManager.shared
        
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(webService.apiKey)"
        
        webService.get(url: url) { (result: Result<DetailsResponse, Error>) in
            switch result {
            case .success(let similarResponse):
                completion(similarResponse)
            case .failure(_):
                print("no data found")
            }
        }
        
    }
    
    static func searchMovie(title: String,completion: @escaping ([Hit])->()) {
        let webService = WebServiceManager.shared
        let title = title.replacingOccurrences(of: " ", with: "%20")
            .replacingOccurrences(of: "'", with: "%27")
        
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(webService.apiKey)&query=\(title)&page=1"
        
        webService.get(url: url) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let similarResponse):
                completion(similarResponse.hits)
            case .failure(_):
                print("nothing found")
            }
        }
        
    }
}
//CoreData
extension MovieServiceManager{
    static func fetchFavourites() -> [MovieID]{
        let context = AppDelegate.coreDataContainer.viewContext
        let request: NSFetchRequest<MovieID> = MovieID.fetchRequest()
        do {
            let fetchedMovies = try context.fetch(request)
            
            return fetchedMovies
        } catch {   return [MovieID]() }
        
    }
    static func saveFavourite(movie: Hit){
        let context = AppDelegate.coreDataContainer.viewContext
        let newID = MovieID( context: context)
        
        newID.id = Int32(movie.id)
        newID.name = movie.title

        do {
            try context.save()
        } catch{
            print("failed")
        }
    }
    static func deleteFavourite(movieID: MovieID) {
        let context = AppDelegate.coreDataContainer.viewContext
        context.delete(movieID)
        do {
            try context.save()
        } catch {
            print("failed")
        }
    }
    
}
