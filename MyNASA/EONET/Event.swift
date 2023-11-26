//
//  Event.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/25/23.
//

import Foundation

struct Event: Codable {
    let title: String
    let id: String
    let categories: [Category]
    let sources: [Source]
}

struct Category: Codable {
    let id: String
    let title: String
}

struct Source: Codable { 
    let id: String
    let url: String
}

struct EventsResponse: Codable {
    let events: [Event]
}

