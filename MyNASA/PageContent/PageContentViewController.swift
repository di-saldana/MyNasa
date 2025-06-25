//
//  PageContentViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var pageIndex = 0
    var descrText = ""
    var imageFilename = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the text color to black
        descriptionTextView.textColor = .black
        
        // Set the background color to white
        descriptionTextView.backgroundColor = .white
        
        // Se establece la imagen del imageView con el nombre de archivo proporcionado
        self.imageView.image = UIImage(named: self.imageFilename)
        
        // Se establece el texto de la descripción en el textView con el texto proporcionado
        self.descriptionTextView.text = self.descrText

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
