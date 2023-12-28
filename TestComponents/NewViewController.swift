//
//  NewViewController.swift
//  TestComponents
//
//  Created by Web and App on 25/12/2023.
//

import Foundation
import UIKit

class NewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("This is the closure")
            }
        }
    }
    
    func test(closure: @escaping () -> Void) {
        closure()
        print("Closure")
    }
}
