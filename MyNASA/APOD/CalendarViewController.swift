//
//  CalendarViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
        
        // Condtraints para iPad
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            label.isHidden = true
//            
//            datePicker.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                datePicker.topAnchor.constraint(equalTo: view.topAnchor),
//                datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//                datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//            ])
//        } else {
//            // Constraints para iPhone
//            datePicker.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            ])
//        }
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
