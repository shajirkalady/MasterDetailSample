//
//  PayloadView.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/24/22.
//

import Foundation
import UIKit

/*
 * Payload view
 */
class PayloadView: UIView {
    let kCONTENT_XIB_NAME = "PayloadView"
    var payload: Payload? = nil

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var payloadIDLabel: UILabel!
    @IBOutlet weak var noradIdsLabel: UILabel!
    @IBOutlet weak var reusedLabel: UILabel!
    @IBOutlet weak var customersLabel: UILabel!
    @IBOutlet weak var nationLabel: UILabel!
    @IBOutlet weak var manufactureLabel: UILabel!
    @IBOutlet weak var payloadTypeLabel: UILabel!
    @IBOutlet weak var payloadMassKgLabel: UILabel!
    @IBOutlet weak var payloadMassLbLabel: UILabel!
    @IBOutlet weak var orbitLabel: UILabel!
    @IBOutlet weak var refSystemLabel: UILabel!
    @IBOutlet weak var regimeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var semiMajorAxisLabel: UILabel!
    @IBOutlet weak var eccentricityLabel: UILabel!
    @IBOutlet weak var perpasLabel: UILabel!
    @IBOutlet weak var apopasisLabel: UILabel!
    @IBOutlet weak var inclinationDegLabel: UILabel!
    @IBOutlet weak var periodMinLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var epochLabel: UILabel!
    @IBOutlet weak var meanMotionLabel: UILabel!
    @IBOutlet weak var ranLabel: UILabel!
    @IBOutlet weak var argOfPerimeterLabel: UILabel!
    @IBOutlet weak var meanAnomalyLabel: UILabel!

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
    func updateView(payload: Payload){
        self.payload = payload
        
        payloadIDLabel.text = payload.payloadId ?? "-"
        
        let joinedNoradID = payload.joinedNoralId()
        noradIdsLabel.text = joinedNoradID.count > 0 ? joinedNoradID : "-"
        if payload.reused ?? false {
            reusedLabel.backgroundColor = .green
        }
        else {
            reusedLabel.backgroundColor = .red
        }
        customersLabel.text = payload.joinedCustomers()
        nationLabel.text = payload.nationality ?? "-"
        manufactureLabel.text = payload.manufacturer ?? "-"
        payloadTypeLabel.text = payload.payloadType ?? "-"
        if let val = payload.payloadMassKg {
            payloadMassKgLabel.text = "\(val)"
        }
        else {
            payloadMassKgLabel.text = "-"
        }
        if let val = payload.payloadMassLbs {
            payloadMassLbLabel.text = "\(val)"
        }
        else {
            payloadMassLbLabel.text = "-"
        }
        orbitLabel.text = payload.orbit ?? "-"
        refSystemLabel.text = payload.orbitParams?.referenceSystem ?? "-"
        regimeLabel.text = payload.orbitParams?.regime ?? "-"
        
        if let val = payload.orbitParams?.longitude {
            longitudeLabel.text = "\(val)"
        }
        else {
            longitudeLabel.text = "-"
        }
        if let val = payload.orbitParams?.semiMajorAxisKm {
            semiMajorAxisLabel.text = "\(val)"
        }
        else {
            semiMajorAxisLabel.text = "-"
        }
        if let val = payload.orbitParams?.eccentricity {
            eccentricityLabel.text = "\(val)"
        }
        else {
            eccentricityLabel.text = "-"
        }
        if let val = payload.orbitParams?.periapsisKm {
            perpasLabel.text = "\(val)"
        }
        else {
            perpasLabel.text = "-"
        }
        if let val = payload.orbitParams?.apoapsisKm {
            apopasisLabel.text = "\(val)"
        }
        else {
            apopasisLabel.text = "-"
        }
        if let val = payload.orbitParams?.inclinationDeg {
            inclinationDegLabel.text = "\(val)"
        }
        else {
            inclinationDegLabel.text = "-"
        }
        if let val = payload.orbitParams?.periodMin {
            periodMinLabel.text = "\(val)"
        }
        else {
            periodMinLabel.text = "-"
        }
        if let val = payload.orbitParams?.lifespanYears {
            lifeSpanLabel.text = "\(val)"
        }
        else {
            lifeSpanLabel.text = "-"
        }
        
        epochLabel.text = payload.orbitParams?.epoch ?? "-"
        
        if let val = payload.orbitParams?.meanMotion {
            meanMotionLabel.text = "\(val)"
        }
        else {
            meanMotionLabel.text = "-"
        }
        if let val = payload.orbitParams?.raan {
            ranLabel.text = "\(val)"
        }
        else {
            ranLabel.text = "-"
        }
        if let val = payload.orbitParams?.argOfPericenter {
            argOfPerimeterLabel.text = "\(val)"
        }
        else {
            argOfPerimeterLabel.text = "-"
        }
        if let val = payload.orbitParams?.meanAnomaly {
            meanAnomalyLabel.text = "\(val)"
        }
        else {
            meanAnomalyLabel.text = "-"
        }
    }
}
