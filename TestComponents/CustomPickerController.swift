//
//  CustomPickerController.swift
//  TestComponents
//
//  Created by Web and App on 22/12/2023.
//

import Foundation
import UIKit
import SnapKit

class CustomPickerController: UIViewController {
    
    var weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var label: UILabel = {
        var label = UILabel()
        label.text = "test label"
        return label
    }()
    
    var picker: UIDatePicker = {
       var picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.backgroundColor = .cyan
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(picker)
//        picker.delegate = self
//        picker.dataSource = self
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        picker.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        picker.addTarget(self, action: #selector(openPicker), for: .touchUpInside)
    }
    
    @objc func openPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        var strDate = formatter.string(from: Date())
        self.label.text = strDate
    }
    
}

//extension CustomPickerController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        weekdays.count
//    }
//}

//extension CustomPickerController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        weekdays[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let selected = weekdays[row]
//        label.text = selected
//    }
//}
