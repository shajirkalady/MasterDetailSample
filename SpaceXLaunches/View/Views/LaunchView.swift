//
//  LaunchView.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation
import UIKit

/*
 * Launch summary view
 * title, image status and other basic datails
 */
class LaunchView: UIView {
    let kCONTENT_XIB_NAME = "LaunchView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainImageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var siteLongLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var failureView: UIView!
    @IBOutlet weak var failureTimeLabel: UILabel!
    @IBOutlet weak var failureAltitudeLabel: UILabel!
    @IBOutlet weak var failureReason: UITextView!
    @IBOutlet weak var failureHeight: NSLayoutConstraint!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var detailsHeight: NSLayoutConstraint!
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var pressKitButton: UIButton!
    @IBOutlet weak var reddCampButton: UIButton!
    @IBOutlet weak var reddLaunchButton: UIButton!
    @IBOutlet weak var reddMediaButton: UIButton!
    @IBOutlet weak var reddRecoButton: UIButton!
    @IBOutlet weak var shipsLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var telemetryButton: UIButton!
    
    var launchData: Launch? = nil
    var viewHeight = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewHeight = frame.height
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    // function for update the UI
    func updateView(data: Launch){
        // Update current data
        launchData = data
        
        // Title and year label update
        titleLabel.text = data.missionName
        yearLabel.text = data.launchYear
        
        // Main image update - Check cache and download the image
        if let url = data.links?.missionPatch ?? data.links?.missionPatchSmall {
            mainImage.cacheAndLoadImage(url: url, completion: {result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.mainImage.image = UIImage(named: "default-launch")
                }
                self.mainImageActivityIndicator.stopAnimating()
            })
        }
        else {
            mainImage.image = UIImage(named: "default-launch")
            self.mainImageActivityIndicator.stopAnimating()
        }
        
        // Launch site details
        siteLabel.text = data.launchSite?.siteName
        siteLongLabel.text = data.launchSite?.siteNameLong
        dateLabel.text = data.launchDateIos?.string()
        
        // Launch status
        if data.launchSuccess ?? false {
            status.text = "Success"
            status.textColor = .green
            failureView.isHidden = true
            failureHeight.constant = 0
            self.viewHeight -= 70
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.viewHeight)
        }
        else {
            status.text = "Failed"
            status.textColor = .red
            if let failure = data.launchFailureDetails { // Show failure details if launch failure
                failureView.isHidden = false
                failureHeight.constant = 70
                if let time = failure.time {
                    failureTimeLabel.text = "\(time)"
                }
                if let altitude = failure.altitude {
                    failureAltitudeLabel.text = "\(altitude)"
                }
                failureReason.text = failure.reason
            }
        }
        
        // Launch Details text view
        if let details = data.details, details.count > 0 {
            detailsView.isHidden = false
            detailsTextView.text = details
            detailsHeight.constant = 100
        }
        else {
            detailsView.isHidden = true
            detailsHeight.constant = 0
            self.viewHeight -= 100
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.viewHeight)
        }
        
        // Update ships, crew and telemetry
        shipsLabel.text = data.ships?.count ?? 0 > 0 ? data.ships?.joined(separator: ", ") : "-"
        crewLabel.text = data.crew?.count ?? 0 > 0 ? data.crew?.joined(separator: ", ") : "-"
        if data.telemetry?.flightClub != nil {
            telemetryButton.isEnabled = true
        }
        else {
            telemetryButton.isEnabled = false
        }
        
        // Manage clickable Links
        var isMediaHeaderVisible = false
        
        if (data.links?.articleLink) != nil {
            articleButton.isEnabled = true
        }
        else {
            articleButton.isEnabled = false
        }
        
        if (data.links?.wikipedia) != nil {
            wikiButton.isEnabled = true
        }
        else {
            wikiButton.isEnabled = false
        }
        
        if (data.links?.videoLink) != nil {
            youtubeButton.isEnabled = true
        }
        else {
            youtubeButton.isEnabled = false
        }
        
        if (data.links?.presskit) != nil {
            pressKitButton.isEnabled = true
            isMediaHeaderVisible = true
        }
        else {
            pressKitButton.isEnabled = false
        }
        
        if (data.links?.redditCampaign) != nil {
            reddCampButton.isEnabled = true
            isMediaHeaderVisible = true
        }
        else {
            reddCampButton.isEnabled = false
        }
        
        if (data.links?.redditLaunch) != nil {
            reddLaunchButton.isEnabled = true
            isMediaHeaderVisible = true
        }
        else {
            reddLaunchButton.isEnabled = false
        }
        
        if (data.links?.redditMedia) != nil {
            reddMediaButton.isEnabled = true
            isMediaHeaderVisible = true
        }
        else {
            reddMediaButton.isEnabled = false
        }
        
        if (data.links?.redditRecovery) != nil {
            reddRecoButton.isEnabled = true
            isMediaHeaderVisible = true
        }
        else {
            reddRecoButton.isEnabled = false
        }
        
        if isMediaHeaderVisible {
            mediaTitleLabel.isEnabled = true
        }
        else {
            mediaTitleLabel.isEnabled = false
        }
    }
    
    @IBAction func linkButtonAction(_ sender: UIButton) {
        // check the button tag and open the respective url
        switch sender.tag {
        case 101:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.articleLink)!)!, options: [:], completionHandler: nil)
        case 102:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.wikipedia)!)!, options: [:], completionHandler: nil)
        case 103:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.videoLink)!)!, options: [:], completionHandler: nil)
        case 104:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.presskit)!)!, options: [:], completionHandler: nil)
        case 105:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.redditCampaign)!)!, options: [:], completionHandler: nil)
        case 106:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.redditLaunch)!)!, options: [:], completionHandler: nil)
        case 107:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.redditMedia)!)!, options: [:], completionHandler: nil)
        case 108:
            UIApplication.shared.open(URL(string: (self.launchData?.links?.redditRecovery)!)!, options: [:], completionHandler: nil)
        case 109:
            UIApplication.shared.open(URL(string: (self.launchData?.telemetry?.flightClub)!)!, options: [:], completionHandler: nil)
        default:
            break
        }
    }
}
