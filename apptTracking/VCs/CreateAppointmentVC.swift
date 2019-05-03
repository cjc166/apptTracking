//
//  CreateAppointmentVC.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import UIKit

class CreateAppointmentVC: UIViewController {
    
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var createAppointmentButton: UIButton!
    @IBOutlet weak var timePickerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        showTimePicker()
    }
    
    @IBAction func createAppointmentButtonPressed(_ sender: Any) {
        print(datePickerTextField.text!)
    }
    
    let datePicker = UIDatePicker()
    
    func showDatePicker(){
        //Format Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        datePickerTextField.inputAccessoryView = toolbar
        datePickerTextField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        datePickerTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    let timePicker = UIDatePicker()
    
    func showTimePicker(){
        //Format Date
        timePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donetimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(canceltimePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        timePickerTextField.inputAccessoryView = toolbar
        timePickerTextField.inputView = timePicker
    }
    
    @objc func donetimePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        //formatter.timeZone = TimeZone(secondsFromGMT: 0)
        timePickerTextField.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func canceltimePicker(){
        self.view.endEditing(true)
    }
    
}
