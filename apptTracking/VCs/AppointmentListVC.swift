//
//  AppointmentListVC.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import UIKit

class AppointmentListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var appointmentListTable: UITableView!
    @IBOutlet weak var upcomingAppointmentsLabel: UILabel!
    
    var appointmentList = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentListTable.delegate = self
        appointmentListTable.dataSource = self
        
        if (appointmentList.count == 0) {
            upcomingAppointmentsLabel.isHidden = false
        } else {
            upcomingAppointmentsLabel.isHidden = true
        }
    }
    
    func tableView(_ appointmentListTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentList.count
    }
    
    func tableView(_ appointmentListTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AppointmentTableViewCell"
        
        guard let cell = appointmentListTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AppointmentTableViewCell else {
            fatalError("The dequeued cell is not an instance of Appointment Table View Cell.")
        }
        
        let appointment = appointmentList[indexPath.row]
        
        cell.appointmentTypeLabel.text = ""//type
        cell.appointmentTimeLabel.text = ""//date/time
        cell.appointmentOfficeLabel.text == ""//office
        
        return cell
    }
    
    func tableView(_ appointmentListTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // what to do when row is selected?
        // segue to view with all information and possible edit/remove info????
        
        /*
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeInstruct") as! RecipeInstructVC
        
        API.getRecipeInfo(id: recipes[indexPath.row].id, completionHandler: { (name, prepTime, ingredients, ingredientsName, instructions, error) in
            
            guard let myRecipe = MyRecipe(name: self.recipes[indexPath.row].name, prepTime: self.recipes[indexPath.row].prepTime, ingredients: ingredients, ingredientsName: ingredientsName, instructions: instructions)
                else {
                    fatalError("Unable to load MyRecipe")
            }
            
            vc.myRecipe = myRecipe
            vc.recipes = self.recipes
            
            self.present(vc, animated: false, completion: {
                print("Load Recipe Info for Selected Recipe with API Call")
            })
        }) */
    }
}
