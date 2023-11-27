//
//  CollectionViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/26/23.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var epicImages = [String]()
    var estimatedWidth = 160.0
    var cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicialización de epicImages
        for i in 1..<25 {
            let image = "\(i).jpeg"
            self.epicImages.append(image)
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Registramos la celda personalizada "ItemCell" en la colección
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        self.setupGridView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupGridView()
    }
    
    // Configuramos la cuadrícula de la vista de colección
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    
    // Manejamos el evento de selección de una celda de la vista de colección
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = epicImages[indexPath.row]
        performSegue(withIdentifier: "EpicSegue", sender: selectedImage)
    }
    
    // Preparamos los datos para la transición a la vista de detalle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EpicSegue",
           let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
           let detailViewController = segue.destination as? DetailViewController {
            
            let selectedImage = epicImages[selectedIndexPath.row]
            detailViewController.imageName = selectedImage
        }
    }
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.epicImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Asignamos la imagen correspondiente a la celda
        if let image = UIImage(named:self.epicImages[indexPath.row]) {
            cell.imageView.image = image
        }
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
        return CGSize(width: width, height: width)
    }
    
    // Calculamos el ancho de las celdas en función del tamaño de la vista y el margen
    func calculateWidth() -> CGFloat {
        let estimatedWidth = CGFloat(estimatedWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
}
