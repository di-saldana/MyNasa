//
//  CalendarViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTabBarController" {
            // Pass the selectedDate to the UITabBarController
            if let tabBarController = segue.destination as? UITabBarController {
                if let imageOfTheDayVC = tabBarController.viewControllers?[0] as? AstronomyPictureViewController {
                    imageOfTheDayVC.selectedDate = selectedDate
                }
                if let infoVC = tabBarController.viewControllers?[1] as? InfoViewController {
                    infoVC.selectedDate = selectedDate
                }
            }
        }
    }

}
