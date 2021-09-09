//
//  Network.swift
//  avitoTestApp
//
//  Created by Ash on 07.09.2021.
//

import Foundation

struct NetworkService {
    private init() {}
    static let shared = NetworkService()
    var jsonCache = NSCache<NSString, AnyObject>()
    
    fileprivate let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    
    func getData(complition: @escaping(Result<Company, Error>) -> ()) {
        
        
    guard let url = URL(string: urlString) else {return}
    var request = URLRequest(url: url,timeoutInterval: 5)
    request.httpMethod = "GET"
        
        if let cachedJsonData = jsonCache.object(forKey: url.absoluteString as NSString) {
            guard let company = cachedJsonData as? Company else {return}
            complition(.success(company))
        } else {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                do {
//                    guard let error = error else {return}
                    if let data = data {
                        let user = try JSONDecoder().decode(UserModel.self, from: data)
                        DispatchQueue.main.async {
                            complition(.success(user.company))
                            self.jsonCache.setObject(user.company as AnyObject, forKey: url.absoluteString as NSString)
                        }
                    
                    } else {
                        guard let error = error else {return}
                        complition(.failure(error))
                    }
                   
                    
                } catch {
                    complition(.failure(error))
                    print("Error", error)
                }
                return
              }
            task.resume()
            
        }
        
    }
    
}
