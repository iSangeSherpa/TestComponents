//
//  DatePickerController.swift
//  TestComponents
//
//  Created by Web and App on 21/12/2023.
//

import Foundation
import UIKit
import SnapKit

class CustomDatePickerController: UIViewController {
    
    var dateTextField: UITextField = {
        var field = UITextField()
        field.placeholder = "Placeholder"
        return field
    }()
    
    let datePicker = DatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        dateTextField.delegate = self
        datePicker.dataSource = datePicker
        datePicker.delegate = datePicker
        
        view.addSubview(dateTextField)
        
        dateTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalToSuperview()
        }
    }
    
    @objc func doneDatePicker() {
        if dateTextField.text == "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateTextField.text = dateFormatter.string(from: Date())
        }
        dateTextField.endEditing(true)
    }
}

extension CustomDatePickerController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.selectRow(datePicker.selectedDate(), inComponent: 0, animated: true)
        textField.inputView = datePicker
        textField.inputView?.backgroundColor = .white
        
        let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: CGFloat(100))))
        toolBar.barStyle = .default
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))
        
        toolBar.setItems([space,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
}
                                
                                
    class DatePicker : UIPickerView {
    var dateCollection = [Date]()
    
    func buildDateCollection()->[Date] {
        dateCollection.append(contentsOf: Date.next(numberOfDays: 0, from: Date()))
        dateCollection.append(contentsOf: Date.next(numberOfDays: 365, from: Date()))
        return dateCollection
    }
    
    func selectedDate()->Int {
        dateCollection = buildDateCollection()
        var row = 0
        for index in dateCollection.indices{
            let today = Date()
            if Calendar.current.compare(today, to: dateCollection[index], toGranularity: .day) == .orderedSame{
                row = index
            }
        }
        return row
    }
}

extension DatePicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateCollection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let label = formatDatePicker(date: dateCollection[row])
        return label
    }
    
    func formatDatePicker(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
}

extension Date {
    static func next(numberOfDays: Int, from startDate: Date) -> [Date]{
        var dates = [Date]()
        for i in 0..<numberOfDays {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
}

