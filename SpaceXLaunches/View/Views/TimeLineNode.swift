//
//  TimeLineNode.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/25/22.
//

import Foundation
import UIKit

/*
 * Tiemline node view
 * Draw the node for timeline and add the texts
 */
class TimeLineNode: UIView {
    var title: String? = nil
    var value: String? = nil
    let leftBorder = 100.0
    let width = 100.0
    let dotSize = 20.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let context = UIGraphicsGetCurrentContext() {
            //Lines
            context.setStrokeColor(UIColor.green.cgColor)
            context.setLineWidth(6)
            context.beginPath()
            context.move(to: CGPoint(x: leftBorder, y: 0.0))
            context.addLine(to: CGPoint(x: leftBorder, y: self.frame.height))
            context.move(to: CGPoint(x: leftBorder, y: self.frame.height/2.0))
            context.addLine(to: CGPoint(x: leftBorder + width, y: self.frame.height/2.0))
            context.strokePath()
            
            //Dots
            var dot1 = UIBezierPath()
            dot1 = UIBezierPath(ovalIn: CGRect(x: leftBorder - dotSize/2, y: (self.frame.height/2.0) - dotSize/2, width: dotSize, height: dotSize))
            UIColor.green.setFill()
            dot1.fill()
            
            var dot2 = UIBezierPath()
            dot2 = UIBezierPath(ovalIn: CGRect(x: leftBorder + width - dotSize/2, y: (self.frame.height/2.0) - dotSize/2, width: dotSize, height: dotSize))
            UIColor.green.setFill()
            dot2.fill()
        }
    }
    
    // function for update the UI
    func updateView(title: String, value: String){
        self.title = title
        self.value = value
        
        self.backgroundColor = .white
        
        let valueLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height/2.0 - 10.0, width: leftBorder - 20, height: 20.0))
        valueLabel.text = value
        valueLabel.textAlignment = .right
        self.addSubview(valueLabel)
        
        let titleLabel = UILabel(frame: CGRect(x: leftBorder + width + 20, y: self.frame.height/2.0 - 10.0, width: self.frame.width - (leftBorder + width), height: 20.0))
        titleLabel.text = title
        titleLabel.textAlignment = .left
        self.addSubview(titleLabel)
    }
}
