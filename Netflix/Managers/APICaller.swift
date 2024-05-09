//
//  APICaller.swift
//  Netflix
//
//  Created by Saadet Şimşek on 10/05/2024.
//

import Foundation

struct Constants{
    static let API_KEY = "2af3f79d6c7f37d98d00c9a6ecbaa78e"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else{
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

