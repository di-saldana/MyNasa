//
//  AstronomyPicture.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import Foundation

struct AstronomyPicture: Codable {
    let date: String? // Fecha de la imagen APOD
    let explanation: String // Explicación de la imagen APOD
    let title: String // Título de la imagen APOD
    let url: String // URL de la imagen APOD

    enum CodingKeys: String, CodingKey {
        case date, explanation, title, url
    }
}
