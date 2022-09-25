//
//  RocketView.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/24/22.
//

import Foundation
import UIKit

/*
 * Rocket summary view
 * basic datails for the rocket
 */
class RocketView: UIView {
    let kCONTENT_XIB_NAME = "RocketView"
    var rocket: Rocket? = nil
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var firstStageContentView: UIView!
    @IBOutlet weak var firstStageContentHeight: NSLayoutConstraint!
    @IBOutlet weak var blocksLabel: UILabel!
    @IBOutlet weak var payloadContentView: UIView!
    @IBOutlet weak var payloadContentHeight: NSLayoutConstraint!
    @IBOutlet weak var fairingsView: UIView!
    @IBOutlet weak var reusedLable: UILabel!
    @IBOutlet weak var recoveryAttemptLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var shipLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    func updateView(rocket: Rocket){
        self.rocket = rocket
        
        nameLabel.text = rocket.rocketName ?? "-"
        typeLabel.text = rocket.rocketType ?? "-"
        
        //Add first stage core
        if let cores = rocket.firstStage?.cores {
            for i in 0 ..< cores.count{
                let offset = i == 0 ? 0 : (CGFloat(i) * (120 + 10))
                let coreView = CoreView(frame: CGRect(x: 0, y: offset, width: self.frame.width, height: 120))
                coreView.updateView(core: cores[i])
                firstStageContentView.addSubview(coreView)
            }
            firstStageContentHeight.constant = CGFloat(cores.count) * (120 + 10)
        }
        
        //Update second stage view
        if let val = rocket.secondStage?.block {
            blocksLabel.text = "\(val)"
        }
        else {
            blocksLabel.text = "-"
        }
        //Update second stage payloads
        if let payloads = rocket.secondStage?.payloads {
            var offset = 0.0
            for i in 0 ..< payloads.count{
                let payloadView = PayloadView(frame: CGRect(x: 0, y: offset, width: self.frame.width, height: 363))
                payloadView.updateView(payload: payloads[i])
                payloadContentView.addSubview(payloadView)
                offset += payloadView.frame.height + 10.0
            }
            payloadContentHeight.constant = CGFloat(payloads.count) * 430.0
        }
        
        // Update fairings
        if rocket.fairings?.reused ?? false {
            reusedLable.backgroundColor = .green
        }
        else {
            reusedLable.backgroundColor = .red
        }
        
        if rocket.fairings?.recovered ?? false {
            recoveredLabel.backgroundColor = .green
        }
        else {
            recoveredLabel.backgroundColor = .red
        }
        
        if rocket.fairings?.recoveryAttempt ?? false {
            recoveryAttemptLabel.backgroundColor = .green
        }
        else {
            recoveryAttemptLabel.backgroundColor = .red
        }
        
        shipLabel.text = rocket.fairings?.ship ?? "-"
        
    }
}
