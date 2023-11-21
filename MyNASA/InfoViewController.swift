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
    
    var selectedDate: Date?
    var astronomyPicture: AstronomyPicture?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch information based on the selected date
        fetchAstronomyPictureInfo()
    }

    func fetchAstronomyPictureInfo() {
        guard let selectedDate = selectedDate else {
            // Handle the case where selectedDate is nil
            return
        }

        // Convert the selectedDate to the desired format for the API request
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: selectedDate)

        let apiKey = "JCcUwEhU7IpzmZ1kIN3rHHtO9rNLZQ0maCPIgvhV"
        let apiUrl = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&date=\(dateString)"

        if let url = URL(string: apiUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    // Handle the error, e.g., show an alert
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let astronomyPicture = try decoder.decode(AstronomyPicture.self, from: data)

                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self?.updateUI(with: astronomyPicture)
                    }
                } catch {
                    // Handle decoding error, e.g., show an alert
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
    }

    func updateUI(with astronomyPicture: AstronomyPicture) {
        titleLabel.text = astronomyPicture.title
        dateLabel.text = astronomyPicture.date
        descriptionTextView.text = astronomyPicture.explanation
    }
}
