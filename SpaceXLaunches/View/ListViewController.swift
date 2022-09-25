//
//  ListViewController.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation
import UIKit

/// Protocol for passing selected row to the detail view
protocol LaunchSelectionDelegate: AnyObject {
    func lauchDidSelect(selectedlaunch: Launch)
}

/*
 * List view
 * Update table on lauch data update
 */
class ListViewController: UITableViewController {
    var launches: [Launch] = []
    var listViewModel = ListViewModel()

    weak var delegate: LaunchSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Table Deleagates
extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Get all the ui componests using the tag assigned and update the values
        if let launchImageView = cell.contentView.viewWithTag(1) as? UIImageView {
            launchImageView.image = UIImage(named: "placeholder")
            
            if let imageUrl = launches[indexPath.row].links?.missionPatchSmall {
                launchImageView.cacheAndLoadImage(url: imageUrl, completion: {result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        launchImageView.image = UIImage(named: "default-launch")
                    }
                    
                    if let activityView = cell.contentView.viewWithTag(6) as? UIActivityIndicatorView {
                        activityView.stopAnimating()
                    }
                })
            }
            else {
                launchImageView.image = UIImage(named: "default-launch")
                if let activityView = cell.contentView.viewWithTag(6) as? UIActivityIndicatorView {
                    activityView.stopAnimating()
                }
            }
        }
        if let missionNameLabel = cell.contentView.viewWithTag(2) as? UILabel {
            missionNameLabel.text = launches[indexPath.row].missionName
        }
        if let rocketNameLabel = cell.contentView.viewWithTag(3) as? UILabel {
            rocketNameLabel.text = launches[indexPath.row].rocket?.rocketName
        }
        if let launchSiteNameLabel = cell.contentView.viewWithTag(4) as? UILabel {
            launchSiteNameLabel.text = launches[indexPath.row].launchSite?.siteName
        }
        if let launchDateLabel = cell.contentView.viewWithTag(5) as? UILabel {
            launchDateLabel.text = launches[indexPath.row].launchDateIos?.string()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.lauchDidSelect(selectedlaunch: launches[indexPath.row])
        if let detailVC = delegate as? DetailViewController,
           let detailNVC = detailVC.navigationController {
            splitViewController?.showDetailViewController(detailNVC, sender: nil)
        }
    }
}
