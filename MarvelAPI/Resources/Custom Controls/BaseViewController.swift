//
//  BaseViewController.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
    private var clearBackgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private var loadingView:UIView = {
        let container = UIView()
        container.isHidden = true
        container.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        container.layer.cornerRadius = 10
        return container
    }()
    
    private var loadingIndicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = false
        return indicator
    }()
    
    private var loadingLabel:UILabel = {
       let label = UILabel()
        label.text = "Loading"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private var stackViewForLoading:UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLoadingView()
    }
    
}

extension BaseViewController {
    private func configLoadingView(){
        self.view.addSubview(clearBackgroundView)
        clearBackgroundView.addSubview(loadingView)
        loadingView.addSubview(stackViewForLoading)
        
        clearBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        stackViewForLoading.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clearBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            clearBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            clearBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            clearBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 100),
            loadingView.widthAnchor.constraint(equalToConstant: 100),
            
            stackViewForLoading.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            stackViewForLoading.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        stackViewForLoading.addArrangedSubview(loadingIndicator)
        stackViewForLoading.addArrangedSubview(loadingLabel)
        
        hideLoadingIndicator()
    }
}
 
extension BaseViewController {
    func showLoadingIndicator() {
        loadingView.isHidden = false
        clearBackgroundView.isHidden = false
        self.view.bringSubviewToFront(clearBackgroundView)
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        self.view.sendSubviewToBack(clearBackgroundView)
        loadingView.isHidden = true
        clearBackgroundView.isHidden = true
        loadingIndicator.stopAnimating()
    }
}
