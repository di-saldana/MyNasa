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
        
        if let imageName = imageName, let image = UIImage(named: imageName) {
            imageView.image = image
        }
        
        if let imageNameWithoutExtension = imageName?.replacingOccurrences(of: ".jpeg", with: "") {
            date.text = "November \(imageNameWithoutExtension), 2023"
        }
    }
}
