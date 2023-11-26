//
//  CollectionViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/23/23.
//


import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var epicImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        
        for i in 1..<25 {
            let image = "\(i).jpeg"
            self.epicImages.append(image)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 2
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            let itemWidth = (UIScreen.main.bounds.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing * 2) / 3 // Adjust the division based on the number of items per row
            let itemHeight = itemWidth
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.epicImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCelda", for: indexPath) as! CollectionViewCell
        
        if let image = UIImage(named:self.epicImages[indexPath.row]) {
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 5
        let numberOfColumns: CGFloat = 3
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - (spacing * (numberOfColumns - 1))) / numberOfColumns
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EpicSegue",
           let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
           let detailViewController = segue.destination as? DetailViewController {
            
            let selectedImage = epicImages[selectedIndexPath.row]
            detailViewController.imageName = selectedImage
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EpicSegue", sender: self)
    }

    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
