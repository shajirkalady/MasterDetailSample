//
//  CoreView.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/24/22.
//

import Foundation
import UIKit

/*
 * Rocket Core  view
 */
class CoreView: UIView {
    let kCONTENT_XIB_NAME = "CoreView"
    var core: Core? = nil
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var blocksLabel: UILabel!
    @IBOutlet weak var flightsLabel: UILabel!
    @IBOutlet weak var landingTypeLabel: UILabel!
    @IBOutlet weak var landingVehicleLabel: UILabel!
    @IBOutlet weak var gridFinsLabel: UILabel!
    @IBOutlet weak var legsLabel: UILabel!
    @IBOutlet weak var reusedLabel: UILabel!
    @IBOutlet weak var landSuccessLabel: UILabel!
    @IBOutlet weak var landingIntentLabel: UILabel!
    
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
    func updateView(core: Core){
        self.core = core
        
        serialLabel.text = core.coreSerial
        if let val = core.flight {
            flightsLabel.text = "\(val)"
        }
        else {
            flightsLabel.text = "-"
        }
        if let val = core.block {
            blocksLabel.text = "\(val)"
        }
        else {
            blocksLabel.text = "-"
        }
        
        landingTypeLabel.text = core.landingType ?? "-"
        landingVehicleLabel.text = core.landingVehicle ?? "-"
        
        if core.gridfins ?? false {
            gridFinsLabel.backgroundColor = .green
        }
        else {
            gridFinsLabel.backgroundColor = .red
        }
        
        if core.legs ?? false {
            legsLabel.backgroundColor = .green
        }
        else {
            legsLabel.backgroundColor = .red
        }
        
        if core.reused ?? false {
            reusedLabel.backgroundColor = .green
        }
        else {
            reusedLabel.backgroundColor = .red
        }
        
        if core.landSuccess ?? false {
            landSuccessLabel.backgroundColor = .green
        }
        else {
            landSuccessLabel.backgroundColor = .red
        }
        
        if core.landingIntent ?? false {
            landingIntentLabel.backgroundColor = .green
        }
        else {
            landingIntentLabel.backgroundColor = .red
        }
    }
}
