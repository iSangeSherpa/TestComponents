//
//  ModalController.swift
//  TestComponents
//
//  Created by Web and App on 22/12/2023.
//

import Foundation
import UIKit
import SnapKit

class CustomPickerController: UIViewController {
    
    var test: UILabel = {
        var label = UILabel()
        label.text = "TEST"
        return label
    }()
    
    var picker = UIPickerView()
    var pickerDates = [Date]()
    
    var defaultHeight: CGFloat = 300
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [test, picker])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
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
        pickerDates = getDateCollection()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .clear
        picker.delegate = self
        picker.dataSource = self
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        stack.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    func animateView() {
        dimmedView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: { [self] in
            self.dimmedView.alpha = 0.6
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        })
    }
}


extension CustomPickerController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { pickerDates.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        formatDate(date: pickerDates[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        test.text = formatDate(date: pickerDates[row])
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, MMM d, yyyy"
        return formatter.string(from: date)
    }
}


extension CustomPickerController {
    func getDateCollection() -> [Date]{
        pickerDates.append(contentsOf: Date.next(numberOfDays: 0, from: Date()))
        pickerDates.append(contentsOf: Date.next(numberOfDays: 365, from: Date()))
        return pickerDates
    }
}


extension Date {
    // get Dates from startDate to numberOfDays
    func next(numberOfDays: Int, startDate: Date) -> [Date] {
        var dates = [Date]()
        for i in 0..<numberOfDays {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
}
