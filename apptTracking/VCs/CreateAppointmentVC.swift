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
    
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var officeTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityAddressTextField: UITextField!
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var timePickerTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var numMonthsReminderTextField: UITextField!
    
    @IBOutlet weak var createAppointmentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        showTimePicker()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.removeKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func removeKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func createAppointmentButtonPressed(_ sender: Any) {
        
        let type: String = typeTextField.text!
        let office: String = officeTextField.text!
        let address: String = streetAddressTextField.text! + " " + cityAddressTextField.text!
        let date = datePickerTextField.text!
        let time = timePickerTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        let numMonths = numMonthsReminderTextField.text!
        
        API.createAppointment(type: type, office: office, address: address, phoneNumber: phoneNumber, date: date, time: time, numMonths: numMonths) { (success) in
            if (success) {
                self.creationSuccessful()
                let reminderDate = self.addXMonths(date: date, numMonths: numMonths)
                Reminders.createReminder(title: "Call " + phoneNumber + " to schedule a " + type, date: self.stringToDate(date: reminderDate) as NSDate)
                print(date)
            } else {
                self.failedCreation()
            }
        }
    }
    
    func creationSuccessful() {
        let dialogMessage = UIAlertController(title: "Success", message: "Creation succesful!", preferredStyle: .alert)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (action) -> Void in
            print("creation successful")
        }
        
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func failedCreation() {
        let dialogMessage = UIAlertController(title: "Error", message: "Error in creation", preferredStyle: .alert)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
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
        formatter.dateFormat = "yyyy/MM/dd"
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
        timePickerTextField.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func canceltimePicker(){
        self.view.endEditing(true)
    }
    
    func stringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let newDate = dateFormatter.date(from: date)
        return newDate!
    }
    
    func addXMonths(date: String, numMonths: String) -> String {
        let arr = date.components(separatedBy: "/")
        var year=Int(arr[0])
        var month = Int(arr[1])
        var day=Int(arr[2])
        
        month = month! + Int(numMonths)!
        if (month! > 12){
            month = month!%12
            year=year!+1
        }
        if (day! > 28){
            day = 28
        }
        
        return String(year!) + "/" + String(month!) + "/" + String(day!)
        

    }
}
