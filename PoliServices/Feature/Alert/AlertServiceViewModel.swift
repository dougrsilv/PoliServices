//
//  AlertServiceViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 11/03/23.
//

import Foundation

protocol AlertServiceViewModelProtocol {
    func reasonService(completion: @escaping(Result<[ReasonModel], ReasonServiceError>) -> ())
}

class AlertServiceViewModel: AlertServiceViewModelProtocol {
    
    private let service: ReasonServiceServiceProtocol
    var serviceModel = [ReasonModel]()
    
    init(service: ReasonServiceServiceProtocol) {
        self.service = service
    }
    
    func reasonService(completion: @escaping (Result<[ReasonModel], ReasonServiceError>) -> ()) {
        service.resonService { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    completion(.failure(erro))
                    print(erro)
                case let .success(success):
                    self.serviceModel = success
                    completion(.success(self.serviceModel))
                }
            }
        }
    }
}
