//
//  NewServicesService.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 06/03/23.
//

import Foundation

enum NewServiceError: Error {
    case decodedError
    case network(Error?)
    //case emptyData
}

protocol NewServicesServiceProtocol {
    func buscarService(completion: @escaping (Result<ServiceModel, NewServiceError>) -> ())
}

class NewServicesService: NewServicesServiceProtocol {
    
    func buscarService(completion: @escaping (Result<ServiceModel, NewServiceError>) -> ()) {
        
        guard let url = URL(string: "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/services") else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                completion(.failure(.network(err)))
                return
            }
            
            do {
                guard let data = data else { return }
                let service = try JSONDecoder().decode(ServiceModel.self, from: data)
                completion(.success(service))
            } catch let err {
                completion(.failure(.decodedError))
                print(err)
                return
            }
        }.resume()
    }
}

