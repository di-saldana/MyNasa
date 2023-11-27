//
//  DetailViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/26/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Comprueba si se ha proporcionado un nombre de imagen y si se puede crear una instancia de UIImage con ese nombre
        if let imageName = imageName, let image = UIImage(named: "high-\(imageName)") {
            imageView.image = image
        }
        
        // Elimina la extensión ".jpeg" del nombre
        if let imageNameWithoutExtension = imageName?.replacingOccurrences(of: ".jpeg", with: "") {
            date.text = "November \(imageNameWithoutExtension), 2023"
        }
    }
}
