//
//  ModalController.swift
//  TestComponents
//
//  Created by Web and App on 22/12/2023.
//

import Foundation
import UIKit
import SnapKit

class ModalController: UIViewController {
    
    var defaultHeight: CGFloat = 300
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .cyan
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    var dimmedView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        view.addSubview(containerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func animateView() {
        dimmedView.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: { [self] in
            self.dimmedView.alpha = 0.6
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        })
    }
}
