//
//  ReasonServiceService.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 11/03/23.
//

import Foundation

enum ReasonServiceError: Error {
    case decodedError
    case network(Error?)
}

protocol ReasonServiceServiceProtocol {
    func resonService(completion: @escaping(Result<[ReasonModel], ReasonServiceError>) -> ())
}

class ReasonServiceService: ReasonServiceServiceProtocol {
    func resonService(completion: @escaping (Result<[ReasonModel], ReasonServiceError>) -> ()) {
        
        //guard let url = URL(string: "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/reasons") else { return }
        guard let url = URL(string: "https://run.mocky.io/v3/f2684fc7-fc83-4ca0-ac4f-ab6c9ae46764") else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                completion(.failure(.network(err)))
            }
            
            do {
                guard let data = data else { return }
                let service = try JSONDecoder().decode([ReasonModel].self, from: data)
                completion(.success(service))
            } catch let err {
                completion(.failure(.decodedError))
                print(err)
                return
            }
        }.resume()
    }
}
