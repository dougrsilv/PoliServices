//
//  AlertServiceViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/03/23.
//

import UIKit

protocol AlertServiceViewControllerLogic: AnyObject {
    func successDataView(data: [ReasonModel])
    func errorDataView()
    func returnPostCardView(result: Bool)
}

protocol AlertServiceViewControllerDelegate: AnyObject {
    func cancelCard(value: Bool)
}

class AlertServiceViewController: UIViewController {
    
    // MARK: - Properties
    
    private let alertServiceView = AlertServiceView()
    private let alertServiceInteractor: AlertServiceInteractor
    
    weak var delegate: AlertServiceViewControllerDelegate?
    
    init(alertServiceInteractor: AlertServiceInteractor) {
        self.alertServiceInteractor = alertServiceInteractor
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
        alertServiceInteractor.reasonService()
    }
    
    // MARK: - Function
    
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
        alertServiceInteractor.reasonPostService(post: reason)
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

extension AlertServiceViewController: AlertServiceViewControllerLogic {
   
    func successDataView(data: [ReasonModel]) {
        self.alertServiceView.reasonServiceView.setupData(setup: data)
        self.alertServiceView.reasonServiceView.reloadInputViews()
    }
    
    func errorDataView() {
        //
    }
    
    func returnPostCardView(result: Bool) {
        self.alertServiceView.activity.startAnimating()
        if result == true {
            self.alertServiceView.activity.stopAnimating()
            self.delegate?.cancelCard(value: result)
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
        } else {
            self.alertServiceView.activity.stopAnimating()
            print("Tela não sumiu!!!!!")
        }
    }
}
