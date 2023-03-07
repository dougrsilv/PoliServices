//
//  NewServicesViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 06/03/23.
//

import Foundation

protocol NewServicesViewModelProtocol {
    func buscarService(completion: @escaping (Result<[Data], NewServiceError>) -> ())
}

class NewServicesViewModel: NewServicesViewModelProtocol {
    
    private let service: NewServicesServiceProtocol
    var serviceViewModel = [Data]()
    
    init(service: NewServicesServiceProtocol) {
        self.service = service
    }
    
    func buscarService(completion: @escaping (Result<[Data], NewServiceError>) -> ()) {
        service.buscarService { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    completion(.failure(erro))
                    print(erro)
                case let .success(success):
                    self.serviceViewModel.append(contentsOf: success.data)
                    completion(.success(self.serviceViewModel))
                }
            }
        }
    }
}

