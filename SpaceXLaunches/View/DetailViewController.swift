//
//  DetailViewController.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import UIKit

/*
 * Detail view
 * Load all the launch sub views
 */
class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var mainContentViewHeight: NSLayoutConstraint!
    
    var refreshUI = false
    
    var launch: Launch? {
        didSet{
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            if self.launch != nil {
                updateUI()
            }
        }
    }
    
    // function for update the UI
    func updateUI() {
        loadViewIfNeeded()
        
        //Clean the views
        for view in self.mainContentView.subviews {
            view.removeFromSuperview()
        }
        
        //Add View to the scrollview
        var offset = CGFloat(0)
        if let data = launch {
            let launchView = LaunchView(frame: CGRect(x: 0.0, y: offset, width: mainContentView.frame.width, height: 960))
            launchView.updateView(data: data)
            mainContentView.addSubview(launchView)
            offset += (launchView.viewHeight + 10)
        }
        
        // Check flicker image and display flicker image view
        if let flickerImages = launch?.links?.flickrImages, flickerImages.count > 0 {
            let flickerView = FlickerView(frame: CGRect(x: 0.0, y: offset, width: mainContentView.frame.width, height: 498))
            flickerView.updateView(images: flickerImages)
            mainContentView.addSubview(flickerView)
            offset += (flickerView.frame.height + 10)
        }
        
        // Add rocket view to the main scroll view
        if let rocket = launch?.rocket {
            let rocketView = RocketView(frame: CGRect(x: 0.0, y: offset, width: mainContentView.frame.width, height: 770))
            rocketView.updateView(rocket: rocket)
            mainContentView.addSubview(rocketView)
            offset += (rocketView.frame.height + 10)
        }
        
        // Add Timeline View
        if let timeline = launch?.sortedTimeline {
            let timeLineParentView =  UIView(frame: CGRect(x: 0.0, y: offset, width: mainContentView.frame.width, height: CGFloat(100*timeline.count + 40)))
            mainContentView.addSubview(timeLineParentView)
            
            var timelineOffset = 10.0
            let headerLabel = UILabel(frame: CGRect(x: 20, y: timelineOffset, width: 100, height: 30.0))
            headerLabel.text = "Timeline"
            headerLabel.textAlignment = .left
            headerLabel.font = .systemFont(ofSize: 22.0)
            timeLineParentView.addSubview(headerLabel)
            timelineOffset += (30 + 10)
            
            for item in timeline {
                let timeLine = TimeLineNode(frame: CGRect(x: 40.0, y: timelineOffset, width: mainContentView.frame.width, height: 100))
                timeLine.updateView(title: item.0.replacingOccurrences(of: "_", with: " "), value: "\(item.1 ?? 0)")
                timeLineParentView.addSubview(timeLine)
                timelineOffset += timeLine.frame.height
            }
            offset += timeLineParentView.frame.height + 10.0
        }
        
        // Reference update dates
        var labelTexts: [String] = []
        if let text = launch?.lastDateUpdate {
            labelTexts.append("* Last updated - \(text.getDate()?.string() ?? "-")")
        }
        if let text = launch?.lastLlLaunchDate {
            labelTexts.append("* Last LL Launch Date - \(text.getDate()?.string() ?? "-")")
        }
        if let text = launch?.lastLlUpdate {
            labelTexts.append("* Last LL Update - \(text.getDate()?.string() ?? "-")")
        }
        if let text = launch?.lastWikiLaunchDate {
            labelTexts.append("* Last wiki launch Date - \(text.getDate()?.string() ?? "-")")
        }
        if let text = launch?.lastWikiRevision {
            labelTexts.append("* Last wiki Revision - \(text)")
        }
        if let text = launch?.lastWikiUpdate {
            labelTexts.append("* Last wiki Update - \(text.getDate()?.string() ?? "-")")
        }
        if let text = launch?.launchDateSource {
            labelTexts.append("* Launch Date Source - \(text)")
        }
        
        for item in labelTexts {
            let label = UILabel(frame: CGRect(x: 20, y: offset, width: mainContentView.frame.width, height: 20.0))
            label.text = item
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 14.0)
            label.tag = Int(offset)
            mainContentView.addSubview(label)
            offset += 28
        }
        
        mainContentViewHeight.constant = offset
        
        // Scroll to top
        mainScrollView.setContentOffset(.zero, animated: true)
    }
}

// MARK: - Lauch Selection Protocol definition
extension DetailViewController: LaunchSelectionDelegate {
    func lauchDidSelect(selectedlaunch: Launch) {
        launch = selectedlaunch
    }
}
