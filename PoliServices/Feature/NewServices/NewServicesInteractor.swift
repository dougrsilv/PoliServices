//
//  NewServicesInteractor.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 16/07/23.
//

import UIKit

protocol NewServicesInteractorLogic {
    func buscarService()
}
 
class NewServicesInteractor: NewServicesInteractorLogic {
    
    private let newServicesPresenter: NewServicesPresenterLogic
    private let service: NewServicesServiceProtocol
    
    init(newServicesPresenter: NewServicesPresenterLogic, service: NewServicesServiceProtocol) {
        self.newServicesPresenter = newServicesPresenter
        self.service = service
    }
    
    func buscarService() {
        service.buscarService { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    self.newServicesPresenter.errorData(error: erro)
                case let .success(success):
                    self.newServicesPresenter.byPassViewModelData(data: success.data)
                }
            }
        }
    }
}
