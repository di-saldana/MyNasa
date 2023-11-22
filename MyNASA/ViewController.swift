//
//  ViewController.swift
//  MyNASA
//
//  Created by Dianelys Saldaña on 11/21/23.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    let pageDescriptions = ["Discover a captivating glimpse into the cosmos by seeing the Astronomy Picture of the Day!", "Learn more about what each image is about!", "Let's start this journey!"]
    let pageImages = ["Comet.png", "Planet-1.png", "Star2.png"]

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
        
//        restartButton.center.y = self.view.frame.size.height - 25
//        skipButton.center.y = self.view.frame.size.height - 25
        
        restartButton.layer.zPosition = 1
        skipButton.layer.zPosition = 1
        
        view.bringSubviewToFront(restartButton)
        view.bringSubviewToFront(skipButton)
    }

    
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

      func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

          let pvc = viewController as! PageContentViewController
          var index = pvc.pageIndex
          print("before")

          if index == 0 || index == Foundation.NSNotFound {
              return nil
          }

          index -= 1
          return self.viewControllerAtIndex(index: index)
      }

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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageDescriptions.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    
    @IBAction func restart(_ sender: UIButton) {
        let startingViewController = self.viewControllerAtIndex(index: 0)
        let viewControllers = [startingViewController!]
        self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewController.NavigationDirection.reverse, animated: false, completion: nil)
        print("RESTART PRESSED")
    }
    
}

