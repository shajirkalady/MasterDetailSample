//
//  SplashViewController.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/24/22.
//

import UIKit

/*
 * Hold the actual UI loading in splash view
 * Retry if the load failure
 */

class SplashViewController: UIViewController {
    
    var listViewModel = ListViewModel()
    var launches: [Launch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
     
    // Load data from server
    // Show alert with retry if failed
    func loadData() {
        listViewModel.loadLaunches { result in
            switch result {
            case .success(let launches):
                let sorted = self.listViewModel.sortedLaunches(launches: launches)
                self.launches = sorted
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showRootView", sender: nil) // Segue to splitview controller
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Launch loading failed with error (\(error))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                        self.loadData()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: Segue delegate
    // Setup the split view controller 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let splitViewController = segue.destination as? UISplitViewController,
          let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
          let listViewController = leftNavController.viewControllers.first as? ListViewController,
          let detailViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? DetailViewController
          else { fatalError() }
                
        detailViewController.launch = self.launches.first
        listViewController.delegate = detailViewController
        listViewController.launches = self.launches
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    }
}
