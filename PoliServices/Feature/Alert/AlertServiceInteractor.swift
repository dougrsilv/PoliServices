//
//  AlertServiceInteractor.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 30/07/23.
//

import Foundation

protocol AlertServiceInteractorLogic {
    func reasonService()
    func reasonPostService(post: String)
}

class AlertServiceInteractor: AlertServiceInteractorLogic {
  
    private let alertServicePresenterLogic: AlertServicePresenterLogic
    private let service: ReasonServiceServiceProtocol
    private let postService: PostAnalitcsService
    
    init(alertServicePresenterLogic: AlertServicePresenterLogic,
         service: ReasonServiceServiceProtocol,
         postService: PostAnalitcsService) {
        self.alertServicePresenterLogic = alertServicePresenterLogic
        self.service = service
        self.postService = postService
    }
    
    func reasonService() {
        service.resonService { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    self.alertServicePresenterLogic.errorDataTransaction()
                    print(erro)
                case let .success(success):
                    self.alertServicePresenterLogic.successDataTransaction(data: success)
                }
            }
        }
    }
    
    func reasonPostService(post: String) {
        self.postService.post(recibo: post) { [weak self] salvo in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.alertServicePresenterLogic.succssOrErrorReturnPost(result: salvo)
            }
        }
    }
}
