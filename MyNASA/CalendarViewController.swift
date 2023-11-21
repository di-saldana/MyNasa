//
//  CalendarViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dateSelected(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowAstronomyPicture", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAstronomyPicture" {
            if let selectedDate = datePicker.date as Date? {
                let destinationVC = segue.destination as! AstronomyPictureViewController
                destinationVC.selectedDate = selectedDate
            }
        }
    }
}
