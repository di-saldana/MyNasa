//
//  AstronomyPictureViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class AstronomyPictureViewController: UIViewController {

    @IBOutlet weak var astronomyImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAstronomyPicture() // Llama a la función para obtener la imagen APOD
    }

    func fetchAstronomyPicture() {
        loadingIndicator.startAnimating() // Inicia la animación del indicador de carga

        let apiKey = "JCcUwEhU7IpzmZ1kIN3rHHtO9rNLZQ0maCPIgvhV"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: selectedDate ?? Date())

        let apiUrl = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&date=\(dateString)"

        if let url = URL(string: apiUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                defer {
                    DispatchQueue.main.async {
                        self.loadingIndicator.stopAnimating() // Detiene la animación del indicador de carga
                        self.loadingIndicator.isHidden = true // Oculta el indicador de carga
                    }
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let astronomyPicture = try decoder.decode(AstronomyPicture.self, from: data)

                        if let imageUrl = URL(string: astronomyPicture.url) {
                            self.loadImageAsync(from: imageUrl) // Carga la imagen de forma asíncrona desde la URL proporcionada
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }

    func loadImageAsync(from url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.astronomyImageView.image = UIImage(data: data) // Establece la imagen descargada en la vista de imagen
                }
            }
        }.resume()
    }
}
