//
//  Event.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/25/23.
//

import Foundation

// Estructura de eventos de EONET NASA
struct Event: Codable {
    let title: String // Título del evento
    let id: String // Identificador del evento
    let categories: [Category] // Categorías del evento
    let sources: [Source] // Fuentes del evento
}

struct Category: Codable {
    let id: String // Identificador de la categoría
    let title: String // Título de la categoría
}

struct Source: Codable {
    let id: String // Identificador de la fuente
    let url: String // URL de la fuente
}

struct EventsResponse: Codable {
    let events: [Event] // Lista de eventos naturales
}


