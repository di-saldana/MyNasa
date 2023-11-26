//
//  ViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var skipButton: UIButton!
    
    // Descripciones de las páginas
    let pageDescriptions = ["Explore some of the most interesting capabilities NASA's API has to offer!", "Experience a captivating glimpse into the cosmos by viewing the Astronomy Picture of the Day!", "Discover EPIC Images of Earth!", "Learn more about the history around natural events all around the world!"]
    
    // Imágenes de las páginas
    let pageImages = ["Saly-1.png", "Rover.png", "Planet-1.png", "Star2.png"]

    var pageViewController : UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Creamos el controlador paginado
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController?
        self.pageViewController?.dataSource = self
        self.pageViewController?.delegate = self

        // Creamos el primer controlador de contenido
        let startingViewController = self.viewControllerAtIndex(index: 0)
        let viewControllers = [startingViewController!]

        self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)

        // Cambiamos el tamaño para que quepa el botón de abajo
        self.pageViewController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 30)

        // Añadimos el primer controlador de contenido
        self.addChild(self.pageViewController!)
        self.view.addSubview((self.pageViewController?.view)!)
        self.pageViewController?.didMove(toParent: self)
        
        skipButton.layer.zPosition = 1
        view.bringSubviewToFront(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false

        // Agregamos restricciones para mantener el botón en la esquina inferior derecha
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }

    
    // Función para obtener el controlador de contenido en un índice dado
    func viewControllerAtIndex(index : Int) -> PageContentViewController? {
          if self.pageDescriptions.count == 0 || index >= self.pageDescriptions.count {
                  return nil
          }
        
          // Crear un nuevo controlador de contenido y pasar los datos
          let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController

          pageContentViewController.imageFilename = self.pageImages[index]
          pageContentViewController.descrText = self.pageDescriptions[index]
          pageContentViewController.pageIndex = index

          return pageContentViewController
      }

    // Función para obtener el controlador de contenido anterior al controlador actual
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

          let pvc = viewController as! PageContentViewController
          var index = pvc.pageIndex

          if index == 0 || index == Foundation.NSNotFound {
              return nil
          }

          index -= 1
          return self.viewControllerAtIndex(index: index)
      }

    // Función para obtener el controlador de contenido siguiente al controlador actual
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

          let pvc = viewController as! PageContentViewController
          var index = pvc.pageIndex

          if index == Foundation.NSNotFound {
              return nil
          }

          index += 1
          if index == self.pageDescriptions.count {
              return nil
          }
          return self.viewControllerAtIndex(index: index)
      }
    
    // Función para obtener el número total de páginas
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageDescriptions.count
    }

    // Función para obtener el índice de la página actual
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // Acción del botón "Start"
    @IBAction func skip(_ sender: UIButton) {
        let mainTabBarViewController = storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
        mainTabBarViewController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarViewController, animated: true, completion: nil)
    }
    
}

