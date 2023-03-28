//
//  AlertServiceViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/03/23.
//

import UIKit

protocol AlertServiceViewControllerDelegate: AnyObject {
    func cancelCard(value: Bool)
}

class AlertServiceViewController: UIViewController {
    
    // MARK: - Properties
    
    private let alertServiceView = AlertServiceView()
    private let viewModel: AlertServiceViewModel
    private let postService = PostAnalitcsService()
    
    weak var delegate: AlertServiceViewControllerDelegate?
    
    init(viewModel: AlertServiceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = alertServiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertServiceView.delegate = self
        show()
        bindDataOptionalCancel()
    }
    
    // MARK: - Function
    
    private func bindDataOptionalCancel() {
        viewModel.reasonService { [weak self] service in
            guard let self = self else { return }
            switch service {
            case let .failure(erro):
                print(erro)
            case .success(_):
                self.alertServiceView.reasonServiceView.setupData(setup: self.viewModel.serviceModel)
                self.alertServiceView.reasonServiceView.reloadInputViews()
            }
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.alertServiceView.alertView.center = self.view.center
                    self.alertServiceView.alertView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                    self.alertServiceView.alertView.alpha = 1
                }
            }
        }
    }
}

// MARK: - AlertServiceViewDelegate

extension AlertServiceViewController: AlertServiceViewDelegate {
    func clickButtonSave(reason: String) {
        postService.post(Recibo: reason) { [weak self] salvo in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.delegate?.cancelCard(value: salvo)
                UIView.animate(withDuration: 0.25) {
                    self.view.alpha = 1
                } completion: { done in
                    if done {
                        UIView.animate(withDuration: 0.25) {
                            self.alertServiceView.alertView.center = self.view.center
                            self.alertServiceView.alertView.alpha = 0
                            self.dismiss(animated: false)
                        }
                    }
                }
            }
        }
    }
    
    func clickButtonCancel() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.alertServiceView.alertView.center = self.view.center
                    self.alertServiceView.alertView.alpha = 0
                    self.dismiss(animated: false)
                }
            }
        }
    }
}
