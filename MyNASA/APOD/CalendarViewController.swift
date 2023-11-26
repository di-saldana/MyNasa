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
    
    // Esta función se ejecuta cuando se selecciona una fecha en el datePicker
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTabBarController" {
            if let tabBarController = segue.destination as? UITabBarController {
                // Asignación de la fecha seleccionada al controlador de vista AstronomyPictureViewController
                if let imageOfTheDayVC = tabBarController.viewControllers?[0] as? AstronomyPictureViewController {
                    imageOfTheDayVC.selectedDate = selectedDate
                }
                // Asignación de la fecha seleccionada al controlador de vista InfoViewController
                if let infoVC = tabBarController.viewControllers?[1] as? InfoViewController {
                    infoVC.selectedDate = selectedDate
                }
            }
        }
    }

}
