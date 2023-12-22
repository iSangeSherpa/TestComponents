//
//  ViewController.swift
//  TestComponents
//
//  Created by Web and App on 21/12/2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Push Controller", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    var label = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(button)
        button.addTarget(self, action: #selector(pushController), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func pushController() {
        let controller = CustomPickerController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
    }

}

