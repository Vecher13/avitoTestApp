//
//  Network.swift
//  avitoTestApp
//
//  Created by Ash on 07.09.2021.
//

import Foundation

struct Network {
    private init() {}
    static let shared = Network()
    var jsonCache = NSCache<NSString, AnyObject>()
    
    fileprivate let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    func getData(complition: @escaping(Company) -> ()) {
        
        
    guard let url = URL(string: urlString) else {return}
    var request = URLRequest(url: url,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
        let cc = URLCache.shared
//        cc.cachedResponse(for: request)
    
        let cacheTask = URLSession.shared.dataTask(with: request)
        cc.getCachedResponse(for: cacheTask) { cache in
            let data = cache?.data
            
            do {
                guard let data = data else {return}
                let user = try JSONDecoder().decode(UserModel.self, from: data)
                DispatchQueue.main.async {
                    complition(user.company)
                  print(user.company.name)
                }
                
            } catch {
                print("Error", error)
            }
            return
        }
        cacheTask.resume()
    }
    
}
