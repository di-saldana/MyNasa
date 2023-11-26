//
//  EventViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/25/23.
//

import Foundation
import UIKit

class EventViewController: UITableViewController, UISearchResultsUpdating {

    private var searchController: UISearchController?
    private var searchResults = [Event]()
    private var eventsResponse: EventsResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "EONET"

        // Cargar los datos del archivo JSON
        if let path = Bundle.main.path(forResource: "events", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let eventsResponse = try? JSONDecoder().decode(EventsResponse.self, from: data) {
            self.eventsResponse = eventsResponse
            searchResults = eventsResponse.events
        }

        // Configurar el controlador de búsqueda
        let searchResultsController = UITableViewController(style: .plain)
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.delegate = self

        // Asignamos esta tabla a nuestro controlador de búsqueda
        self.searchController = UISearchController(searchResultsController: searchResultsController)
        self.searchController?.searchResultsUpdater = self

        // Especificamos el tamaño de la barra de búsqueda
        if let frame = self.searchController?.searchBar.frame {
            self.searchController?.searchBar.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 44.0)
        }

        // La añadimos a la cabecera de la tabla
        self.tableView.tableHeaderView = self.searchController?.searchBar

        // Esto es para indicar que nuestra vista de tabla de búsqueda se superpondrá a la ya existente
        self.definesPresentationContext = true
    }

    // Otros métodos de la tabla
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let src = self.searchController?.searchResultsController as! UITableViewController

        if tableView == src.tableView {
            return self.searchResults.count
        } else {
            return self.searchResults.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "idCelda", for: indexPath)

        let src = self.searchController?.searchResultsController as! UITableViewController
        let object: Event

        if tableView == src.tableView {
            object = self.searchResults[indexPath.row]
        } else {
            object = self.searchResults[indexPath.row]
        }

        cell.textLabel!.text = object.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object: Event

        if let indexPath = self.tableView.indexPathForSelectedRow {
            object = self.searchResults[indexPath.row]
        } else {
            let sc = self.searchController?.searchResultsController as! UITableViewController
            object = self.searchResults[(sc.tableView.indexPathForSelectedRow?.row)!]
        }

        // Abrir la URL fuente en el navegador web
        if let url = URL(string: object.sources.first?.url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text, !searchString.isEmpty else {
            searchResults = eventsResponse?.events ?? [] 
            // Recargar los datos en la vista de tabla de resultados de búsqueda
            if let searchResultsController = searchController.searchResultsController as? UITableViewController {
                searchResultsController.tableView.reloadData()
            }
            return
        }

        searchResults = eventsResponse?.events.filter { $0.title.lowercased().contains(searchString.lowercased()) } ?? []
        if let searchResultsController = searchController.searchResultsController as? UITableViewController {
            searchResultsController.tableView.reloadData()
        }
    }
}
