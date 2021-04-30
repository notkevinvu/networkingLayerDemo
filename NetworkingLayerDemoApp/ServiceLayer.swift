//
//  ServiceLayer.swift
//  NetworkingLayerDemoApp
//
//  Created by Kevin Vu on 3/30/21.
//

import Foundation

final class ServiceLayer: NSObject {
    
    // using 'class func' so we can call the function directly on the class
    // without having to instantiate it
    class func request<T: Codable>(router: Router, completion: @escaping (Result<[String: [T]], Error>) -> Void ) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            guard
                response != nil,
                let data = data
            else { return }
            
            let responseObject = try! JSONDecoder().decode([String: [T]].self, from: data)
            
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        
        dataTask.resume()
    }
    
}
