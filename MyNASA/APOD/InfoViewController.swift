//
//  InfoViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var selectedDate: Date? // Fecha seleccionada por el usuario
    var astronomyPicture: AstronomyPicture? // Objeto que contiene la información de la imagen APOD

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        dateLabel.text = ""
        descriptionTextView.text = ""
        loadingIndicator.startAnimating() // Iniciar la animación del indicador de carga
        
        fetchAstronomyPictureInfo() // Obtener la información de la imagen APOD
    }

    func fetchAstronomyPictureInfo() {

        guard let selectedDate = selectedDate else {
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: selectedDate)

        let apiKey = "JCcUwEhU7IpzmZ1kIN3rHHtO9rNLZQ0maCPIgvhV"
        let apiUrl = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&date=\(dateString)"

        if let url = URL(string: apiUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                defer {
                    DispatchQueue.main.async {
                        self?.loadingIndicator.stopAnimating() // Detener la animación del indicador de carga
                        self?.loadingIndicator.isHidden = true // Ocultar el indicador de carga
                    }
                }
                
                guard let data = data, error == nil else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let astronomyPicture = try decoder.decode(AstronomyPicture.self, from: data)

                    DispatchQueue.main.async {
                        self?.updateUI(with: astronomyPicture) // Actualizar la interfaz de usuario con la información de la APOD
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
    }

    // Actualizar labels
    func updateUI(with astronomyPicture: AstronomyPicture) {
        titleLabel.text = astronomyPicture.title
        dateLabel.text = astronomyPicture.date
        descriptionTextView.text = astronomyPicture.explanation
    }
}
