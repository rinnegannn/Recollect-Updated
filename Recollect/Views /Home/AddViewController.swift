//
//  AddViewController.swift
//  Recollect
//
//  Created by student on 2022-07-23.
//

import UIKit
// View Controller for adding a new reminder 
class AddViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    public var completion: ((String, String, Date) -> Void)?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self



        // Do any additional setup after loading the view.
    }
    
    
    // Save button 
    @IBAction func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
            let bodyText = bodyField.text, !bodyText.isEmpty {
            let targetDate = datePicker.date
            completion?(titleText, bodyText, targetDate)
        }
            
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
    
    
    
    }
    }
