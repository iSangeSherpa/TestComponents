//
//  ViewController.swift
//  TestComponents
//
//  Created by Web and App on 21/12/2023.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    var relay = PublishRelay<String>()
    
    var label: UILabel = {
        var label = UILabel()
        label.text = "Test"
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Push Controller", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(button)
        button.addTarget(self, action: #selector(pushController), for: .touchUpInside)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-20)
        }
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func pushController() {
        let controller = CustomPickerController()
        controller.modalPresentationStyle = .overCurrentContext
        self.label.text = controller.viewmodel.relay.value
        self.present(controller, animated: false)
    }

}

