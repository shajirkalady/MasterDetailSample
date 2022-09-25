//
//  ListViewModel.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

class ListViewModel {
    let launchesUrl = URL(string: "https://api.spacexdata.com/v3/launches")!
    
    func sortedLaunches(launches: [Launch]) -> [Launch] {
        let sortedList = launches.sorted(by: { ($0.launchDateIos ?? Date()).compare($1.launchDateIos ?? Date()) == .orderedDescending })
        return sortedList
    }
    
    func loadLaunches(completion: @escaping(Result<[Launch], Error>) -> Void) {
        var request = URLRequest(url: launchesUrl,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                if let err = error {
                    completion(.failure(err))
                }
                else {
                    completion(.failure(NwError.networkError))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launches = try decoder.decode([Launch].self, from: data)
                completion(.success(launches))
                return
            }
            catch {
                print(error.localizedDescription)
                completion(.failure(NwError.decodeError))
                return
            }
        }

        task.resume()
    }
    
    func loadLaunchesFromFile(completion: @escaping(Result<[Launch], Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "launches", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launches = try decoder.decode([Launch].self, from: data)
                completion(.success(launches))
                return
            } catch {
                print(error.localizedDescription)
                completion(.failure(NwError.decodeError))
                return
            }
        }
    }
}

enum NwError: Error {
    case networkError
    case decodeError
}
