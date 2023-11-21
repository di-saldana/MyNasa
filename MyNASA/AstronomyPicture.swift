//
//  AstronomyPicture.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import Foundation

struct AstronomyPicture: Codable {
    let date: String
    let explanation: String
    let hdurl: String
    let mediaType: String?
    let serviceVersion: String?
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl, mediaType, serviceVersion, title, url
    }
}


